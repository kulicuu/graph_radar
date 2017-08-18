

# NOTE The UI support for features:
# 1.  loading dictionary file from disc, caching raw in redis as a string, in the
# main meta hash of that.


# NOTE to reduce the work for the moment we'll just read in all the dictionaries as lists
# on the server side on startup.  then these can be applied to various parser/data-strucutre-factories
# and these can be browsed and tested


list_of_components =
    'raw dictionary list': 'aeu'
    'browse dictionary list pane': 'sth'






raw_dctn_pane = (props, state) ->
    div
        style:
            display: 'flex'
            flexDirection: 'column'
            alignItems: 'start'
            justifyContent: 'start'
            background: 'palegreen'
            width: '30%'
            height: '60%'
        div
            style:
                marginTop: 10
            for v, idx in props.raw_dctns_list
                do (v) =>
                    p
                        onClick: (e) =>
                            c v
                            props.browse_dctn v.filename
                        style:
                            cursor: 'pointer'
                            fontSize: 10
                            margin: 0
                            marginTop: 5
                            marginLeft: 10
                        key: "dctns_filename#{idx}"
                        v.filename.split('.')[0]



browse_raw = (props, state) ->
    div
        style:
            background: 'chartreuse'
            scroll: 'auto'
        for word, idx in props.dctn_blob.split('\n')
            p
                style:
                    margin: 4
                    fontSize: 8
                key: "word#{idx}"
                "   #{word}"




comp = rr
    componentWillMount: ->
        # c 'okay'
        @props.get_raw_dctns_list()

    render: ->
        div
            style:
                display: 'flex'
                # flexDirection: 'column'
                # alignItems: 'center'
                # justifyContent: 'center'
                backgroundColor: 'lightsteelblue'
                height: '100%'
                width: '100%'
            raw_dctn_pane @props, @state

            c @props
            browse_raw @props, @state
            # div null,
            #     for word, idx in @props.dctn_blob.split('\n')
            #         p
            #             style:
            #                 margin: 4
            #                 fontSize: 8
            #             key: "word#{idx}"
            #             "   #{word}"
            # "aeosunth"











map_state_to_props = (state) ->
    state.get('lookup').toJS()

map_dispatch_to_props = (dispatch) ->

    browse_dctn: (filename) ->
        dispatch
            type: 'browse_dctn'
            payload:
                filename: filename

    get_raw_dctns_list: ->
        dispatch
            type: 'get_raw_dctns_list'


    change_to_autocomplete_mode: ->
        dispatch
            type: 'change_to_autocomplete_mode'

    change_to_spellcheck_mode: ->
        dispatch
            type: 'change_to_spellcheck_mode'


    lookup_prefix: ({ payload }) ->
        dispatch
            type: 'lookup_prefix'
            payload: payload

    placeholder: ({ payload }) ->
        dispatch
            type: 'placeholder'


exports.default = connect(map_state_to_props, map_dispatch_to_props)(comp)
