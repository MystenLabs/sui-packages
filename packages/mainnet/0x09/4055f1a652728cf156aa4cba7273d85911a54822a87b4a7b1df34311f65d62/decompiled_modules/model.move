module 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::model {
    struct Model has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        task_type: 0x1::string::String,
        graphs: vector<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>,
        scale: u64,
        training_dataset_id: 0x1::option::Option<0x2::object::ID>,
        test_dataset_ids: 0x1::option::Option<vector<0x2::object::ID>>,
        state: u8,
        current_graph_idx: u64,
        current_layer_idx: u64,
    }

    struct PredictionCompleted has copy, drop {
        model_id: address,
        output_magnitude: vector<u64>,
        output_sign: vector<u64>,
        argmax_idx: u64,
    }

    struct ModelCreated has copy, drop {
        model_id: address,
        name: 0x1::string::String,
        task_type: 0x1::string::String,
    }

    struct ModelCompleted has copy, drop {
        model_id: address,
        graph_count: u64,
        total_layers: u64,
    }

    struct GraphAdded has copy, drop {
        model_id: address,
        graph_idx: u64,
    }

    struct LayerAdded has copy, drop {
        model_id: address,
        graph_idx: u64,
        layer_idx: u64,
        in_dimension: u64,
        out_dimension: u64,
    }

    struct LayerPartialComputed has copy, drop {
        model_id: address,
        layer_idx: u64,
        output_dim_idx: u64,
        output_magnitude: u64,
        output_sign: u64,
        is_last_dimension: bool,
    }

    struct LayerStarted has copy, drop {
        model_id: address,
        graph_idx: u64,
        layer_idx: u64,
        in_dimension: u64,
        out_dimension: u64,
    }

    struct LayerCompleted has copy, drop {
        model_id: address,
        graph_idx: u64,
        layer_idx: u64,
        in_dimension: u64,
        out_dimension: u64,
        is_final_layer: bool,
    }

    struct WeightsChunkAdded has copy, drop {
        model_id: address,
        graph_idx: u64,
        layer_idx: u64,
        start_idx: u64,
        chunk_size: u64,
        is_last_chunk: bool,
    }

    struct BiasesChunkAdded has copy, drop {
        model_id: address,
        graph_idx: u64,
        layer_idx: u64,
        start_idx: u64,
        chunk_size: u64,
        is_last_chunk: bool,
    }

    struct MODEL has drop {
        dummy_field: bool,
    }

    struct OpenGraphManagerCap has key {
        id: 0x2::object::UID,
    }

    public fun add_layer(arg0: &mut Model, arg1: u64, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>) {
        assert!(arg1 < 0x1::vector::length<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(&arg0.graphs), 1018);
        arg0.current_graph_idx = arg1;
        assert!(0x1::vector::length<u64>(&arg5) == 0x1::vector::length<u64>(&arg6), 1008);
        assert!(0x1::vector::length<u64>(&arg7) == 0x1::vector::length<u64>(&arg8), 1009);
        assert!(0x1::vector::length<u64>(&arg5) == arg3 * arg4, 1020);
        assert!(0x1::vector::length<u64>(&arg7) == arg4, 1020);
        assert!(0x1::vector::length<u64>(&arg5) + 0x1::vector::length<u64>(&arg6) + 0x1::vector::length<u64>(&arg7) + 0x1::vector::length<u64>(&arg8) <= 3000, 1023);
        0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::add_layer(0x1::vector::borrow_mut<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(&mut arg0.graphs, arg1), 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::new_layer(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg0.scale));
        arg0.current_layer_idx = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::get_layer_count(0x1::vector::borrow<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(&arg0.graphs, arg1)) - 1;
        let v0 = LayerAdded{
            model_id      : 0x2::object::id_address<Model>(arg0),
            graph_idx     : arg1,
            layer_idx     : arg0.current_layer_idx,
            in_dimension  : arg3,
            out_dimension : arg4,
        };
        0x2::event::emit<LayerAdded>(v0);
    }

    public fun add_biases_chunk(arg0: &mut Model, arg1: u64, arg2: vector<u64>, arg3: vector<u64>, arg4: bool) {
        assert!(arg0.state == 0, 1021);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg3), 1009);
        let v0 = arg0.current_graph_idx;
        let v1 = arg0.current_layer_idx;
        assert!(v0 < 0x1::vector::length<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(&arg0.graphs), 1018);
        assert!(v1 < 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::get_layer_count(0x1::vector::borrow<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(&arg0.graphs, v0)), 1015);
        0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::add_biases_chunk(0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::get_layer_at_mut(0x1::vector::borrow_mut<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(&mut arg0.graphs, v0), v1), arg1, arg2, arg3);
        let v2 = BiasesChunkAdded{
            model_id      : 0x2::object::id_address<Model>(arg0),
            graph_idx     : v0,
            layer_idx     : v1,
            start_idx     : arg1,
            chunk_size    : 0x1::vector::length<u64>(&arg2),
            is_last_chunk : arg4,
        };
        0x2::event::emit<BiasesChunkAdded>(v2);
    }

    public fun add_weights_chunk(arg0: &mut Model, arg1: u64, arg2: vector<u64>, arg3: vector<u64>, arg4: bool) {
        assert!(arg0.state == 0, 1021);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg3), 1008);
        let v0 = arg0.current_graph_idx;
        let v1 = arg0.current_layer_idx;
        assert!(v0 < 0x1::vector::length<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(&arg0.graphs), 1018);
        assert!(v1 < 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::get_layer_count(0x1::vector::borrow<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(&arg0.graphs, v0)), 1015);
        0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::add_weights_chunk(0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::get_layer_at_mut(0x1::vector::borrow_mut<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(&mut arg0.graphs, v0), v1), arg1, arg2, arg3);
        let v2 = WeightsChunkAdded{
            model_id      : 0x2::object::id_address<Model>(arg0),
            graph_idx     : v0,
            layer_idx     : v1,
            start_idx     : arg1,
            chunk_size    : 0x1::vector::length<u64>(&arg2),
            is_last_chunk : arg4,
        };
        0x2::event::emit<WeightsChunkAdded>(v2);
    }

    public fun add_graph(arg0: &mut Model) {
        assert!(arg0.state == 0, 1021);
        0x1::vector::push_back<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(&mut arg0.graphs, 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::new_graph());
        let v0 = 0x1::vector::length<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(&arg0.graphs) - 1;
        arg0.current_graph_idx = v0;
        arg0.current_layer_idx = 0;
        let v1 = GraphAdded{
            model_id  : 0x2::object::id_address<Model>(arg0),
            graph_idx : v0,
        };
        0x2::event::emit<GraphAdded>(v1);
    }

    public fun add_test_dataset(arg0: &mut Model, arg1: &0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::dataset::Dataset) {
        if (0x1::option::is_none<vector<0x2::object::ID>>(&arg0.test_dataset_ids)) {
            arg0.test_dataset_ids = 0x1::option::some<vector<0x2::object::ID>>(0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x1::option::borrow_mut<vector<0x2::object::ID>>(&mut arg0.test_dataset_ids), 0x2::object::id<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::dataset::Dataset>(arg1));
    }

    public fun complete_layer(arg0: &mut Model, arg1: bool) {
        assert!(arg0.state == 0, 1021);
        let v0 = arg0.current_graph_idx;
        let v1 = arg0.current_layer_idx;
        assert!(v0 < 0x1::vector::length<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(&arg0.graphs), 1018);
        assert!(v1 < 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::get_layer_count(0x1::vector::borrow<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(&arg0.graphs, v0)), 1015);
        let v2 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::get_layer_at(0x1::vector::borrow<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(&arg0.graphs, v0), v1);
        let v3 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::get_in_dimension(v2);
        let v4 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::get_out_dimension(v2);
        let v5 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::get_weight_tensor(v2);
        let v6 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::get_bias_tensor(v2);
        let v7 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::tensor::get_magnitude(v5);
        let v8 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::tensor::get_sign(v5);
        assert!(0x1::vector::length<u64>(&v7) == v3 * v4, 1020);
        assert!(0x1::vector::length<u64>(&v8) == v3 * v4, 1020);
        let v9 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::tensor::get_magnitude(v6);
        let v10 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::tensor::get_sign(v6);
        assert!(0x1::vector::length<u64>(&v9) == v4, 1020);
        assert!(0x1::vector::length<u64>(&v10) == v4, 1020);
        let v11 = LayerCompleted{
            model_id       : 0x2::object::id_address<Model>(arg0),
            graph_idx      : v0,
            layer_idx      : v1,
            in_dimension   : v3,
            out_dimension  : v4,
            is_final_layer : arg1,
        };
        0x2::event::emit<LayerCompleted>(v11);
        if (arg1) {
            arg0.state = 1;
        };
    }

    public fun complete_model(arg0: Model) {
        assert!(arg0.state == 1, 1021);
        let v0 = ModelCompleted{
            model_id     : 0x2::object::id_address<Model>(&arg0),
            graph_count  : 0x1::vector::length<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(&arg0.graphs),
            total_layers : get_total_layers(&arg0),
        };
        0x2::event::emit<ModelCompleted>(v0);
        0x2::transfer::share_object<Model>(arg0);
    }

    public fun create_model(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::option::Option<0x2::object::ID>, arg5: 0x1::option::Option<vector<0x2::object::ID>>, arg6: &mut 0x2::tx_context::TxContext) : Model {
        assert!(arg3 > 0, 1010);
        let v0 = Model{
            id                  : 0x2::object::new(arg6),
            name                : arg0,
            description         : arg1,
            task_type           : arg2,
            graphs              : 0x1::vector::empty<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(),
            scale               : arg3,
            training_dataset_id : arg4,
            test_dataset_ids    : arg5,
            state               : 0,
            current_graph_idx   : 0,
            current_layer_idx   : 0,
        };
        let v1 = ModelCreated{
            model_id  : 0x2::object::id_address<Model>(&v0),
            name      : arg0,
            task_type : arg2,
        };
        0x2::event::emit<ModelCreated>(v1);
        v0
    }

    public fun delete_model(arg0: Model, arg1: &OpenGraphManagerCap) {
        let Model {
            id                  : v0,
            name                : _,
            description         : _,
            task_type           : _,
            graphs              : _,
            scale               : _,
            training_dataset_id : _,
            test_dataset_ids    : _,
            state               : _,
            current_graph_idx   : _,
            current_layer_idx   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun find_argmax(arg0: &vector<u64>, arg1: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<u64>(arg0);
        if (v1 > 0) {
            let v2 = 0;
            while (v2 < v1) {
                let v3 = 0x1::vector::borrow<u64>(arg0, v2);
                if (*0x1::vector::borrow<u64>(arg1, v2) == 0 && *v3 > v0) {
                    v0 = *v3;
                };
                v2 = v2 + 1;
            };
        };
        0
    }

    public fun get_description(arg0: &Model) : &0x1::string::String {
        &arg0.description
    }

    public fun get_name(arg0: &Model) : &0x1::string::String {
        &arg0.name
    }

    public fun get_scale(arg0: &Model) : u64 {
        arg0.scale
    }

    public fun get_task_type(arg0: &Model) : &0x1::string::String {
        &arg0.task_type
    }

    public fun get_test_dataset_count(arg0: &Model) : u64 {
        if (0x1::option::is_none<vector<0x2::object::ID>>(&arg0.test_dataset_ids)) {
            return 0
        };
        0x1::vector::length<0x2::object::ID>(0x1::option::borrow<vector<0x2::object::ID>>(&arg0.test_dataset_ids))
    }

    public fun get_test_dataset_ids(arg0: &Model) : &0x1::option::Option<vector<0x2::object::ID>> {
        &arg0.test_dataset_ids
    }

    fun get_total_layers(arg0: &Model) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(&arg0.graphs)) {
            v0 = v0 + 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::get_layer_count(0x1::vector::borrow<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(&arg0.graphs, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_training_dataset_id(arg0: &Model) : 0x1::option::Option<0x2::object::ID> {
        arg0.training_dataset_id
    }

    fun init(arg0: MODEL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = new_open_graph_manager_cap(arg0, arg1);
        0x2::transfer::transfer<OpenGraphManagerCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun new_open_graph_manager_cap(arg0: MODEL, arg1: &mut 0x2::tx_context::TxContext) : OpenGraphManagerCap {
        OpenGraphManagerCap{id: 0x2::object::new(arg1)}
    }

    public fun predict_layer_partial(arg0: &Model, arg1: u64, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>) : (vector<u64>, vector<u64>, u64, bool) {
        assert!(0x1::vector::length<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(&arg0.graphs) > 0, 1014);
        let v0 = 0x1::vector::borrow<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(&arg0.graphs, 0);
        let v1 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::get_layer_count(v0);
        assert!(arg1 < v1, 1015);
        let v2 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::get_layer_at(v0, arg1);
        let v3 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::get_in_dimension(v2);
        let v4 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::get_out_dimension(v2);
        assert!(arg2 < v4, 1016);
        assert!(0x1::vector::length<u64>(&arg3) == v3, 1012);
        assert!(0x1::vector::length<u64>(&arg4) == v3, 1012);
        let v5 = arg1 == v1 - 1;
        let v6 = arg2 == v4 - 1;
        let v7 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::get_weight_tensor(v2);
        let v8 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::get_bias_tensor(v2);
        let v9 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::tensor::get_magnitude(v7);
        let v10 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::tensor::get_sign(v7);
        let v11 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::tensor::get_magnitude(v8);
        let v12 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::tensor::get_sign(v8);
        let v13 = 0;
        let v14 = 0;
        if (arg2 < 0x1::vector::length<u64>(&v11)) {
            v13 = *0x1::vector::borrow<u64>(&v11, arg2);
            v14 = *0x1::vector::borrow<u64>(&v12, arg2);
        };
        let v15 = 0;
        while (v15 < v3) {
            let v16 = v15 * v4 + arg2;
            if (v16 < 0x1::vector::length<u64>(&v9)) {
                let (v17, v18) = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::math::multiply(*0x1::vector::borrow<u64>(&arg4, v15), *0x1::vector::borrow<u64>(&arg3, v15), *0x1::vector::borrow<u64>(&v10, v16), *0x1::vector::borrow<u64>(&v9, v16), arg0.scale);
                let (v19, v20) = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::math::add(v14, v13, v17, v18);
                v13 = v20;
                v14 = v19;
            };
            v15 = v15 + 1;
        };
        if (!v5 && v14 == 1) {
            v13 = 0;
            v14 = 0;
        };
        0x1::vector::push_back<u64>(&mut arg5, v13);
        0x1::vector::push_back<u64>(&mut arg6, v14);
        let v21 = LayerPartialComputed{
            model_id          : 0x2::object::id_address<Model>(arg0),
            layer_idx         : arg1,
            output_dim_idx    : arg2,
            output_magnitude  : v13,
            output_sign       : v14,
            is_last_dimension : v6,
        };
        0x2::event::emit<LayerPartialComputed>(v21);
        if (v5 && v6) {
            let v22 = PredictionCompleted{
                model_id         : 0x2::object::id_address<Model>(arg0),
                output_magnitude : arg5,
                output_sign      : arg6,
                argmax_idx       : find_argmax(&arg5, &arg6),
            };
            0x2::event::emit<PredictionCompleted>(v22);
        };
        (arg5, arg6, arg2, v6)
    }

    public fun predict_layer_partial_chunked(arg0: &Model, arg1: u64, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u64>, arg10: vector<u64>) : (vector<u64>, vector<u64>, u64, u64) {
        assert!(0x1::vector::length<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(&arg0.graphs) > 0, 1014);
        let v0 = 0x1::vector::borrow<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(&arg0.graphs, 0);
        let v1 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::get_layer_count(v0);
        assert!(arg1 < v1, 1015);
        let v2 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::get_layer_at(v0, arg1);
        let v3 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::get_in_dimension(v2);
        let v4 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::get_out_dimension(v2);
        assert!(arg2 < v4, 1016);
        assert!(0x1::vector::length<u64>(&arg3) == v3, 1012);
        assert!(0x1::vector::length<u64>(&arg4) == v3, 1012);
        let v5 = if (arg5 + arg6 > v3) {
            v3
        } else {
            arg5 + arg6
        };
        let v6 = arg1 == v1 - 1;
        let v7 = arg2 == v4 - 1;
        let v8 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::get_weight_tensor(v2);
        let v9 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::get_bias_tensor(v2);
        let v10 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::tensor::get_magnitude(v8);
        let v11 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::tensor::get_sign(v8);
        let v12 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::tensor::get_magnitude(v9);
        let v13 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::tensor::get_sign(v9);
        let v14 = arg7;
        let v15 = arg8;
        if (arg5 == 0) {
            if (arg2 < 0x1::vector::length<u64>(&v12)) {
                v14 = *0x1::vector::borrow<u64>(&v12, arg2);
                v15 = *0x1::vector::borrow<u64>(&v13, arg2);
            };
        };
        while (arg5 < v5) {
            let v16 = arg5 * v4 + arg2;
            if (v16 < 0x1::vector::length<u64>(&v10)) {
                let (v17, v18) = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::math::multiply(*0x1::vector::borrow<u64>(&arg4, arg5), *0x1::vector::borrow<u64>(&arg3, arg5), *0x1::vector::borrow<u64>(&v11, v16), *0x1::vector::borrow<u64>(&v10, v16), arg0.scale);
                let (v19, v20) = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::math::add(v15, v14, v17, v18);
                v14 = v20;
                v15 = v19;
            };
            arg5 = arg5 + 1;
        };
        if (v5 == v3) {
            if (!v6 && v15 == 1) {
                v14 = 0;
                v15 = 0;
            };
            0x1::vector::push_back<u64>(&mut arg9, v14);
            0x1::vector::push_back<u64>(&mut arg10, v15);
            let v21 = LayerPartialComputed{
                model_id          : 0x2::object::id_address<Model>(arg0),
                layer_idx         : arg1,
                output_dim_idx    : arg2,
                output_magnitude  : v14,
                output_sign       : v15,
                is_last_dimension : v7,
            };
            0x2::event::emit<LayerPartialComputed>(v21);
            if (v6 && v7) {
                let v22 = PredictionCompleted{
                    model_id         : 0x2::object::id_address<Model>(arg0),
                    output_magnitude : arg9,
                    output_sign      : arg10,
                    argmax_idx       : find_argmax(&arg9, &arg10),
                };
                0x2::event::emit<PredictionCompleted>(v22);
            };
        };
        (arg9, arg10, v14, v15)
    }

    public fun remove_test_dataset(arg0: &mut Model, arg1: 0x2::object::ID) : bool {
        if (0x1::option::is_none<vector<0x2::object::ID>>(&arg0.test_dataset_ids)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(0x1::option::borrow<vector<0x2::object::ID>>(&arg0.test_dataset_ids))) {
            if (*0x1::vector::borrow<0x2::object::ID>(0x1::option::borrow<vector<0x2::object::ID>>(&arg0.test_dataset_ids), v0) == arg1) {
                0x1::vector::remove<0x2::object::ID>(0x1::option::borrow_mut<vector<0x2::object::ID>>(&mut arg0.test_dataset_ids), v0);
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun start_layer(arg0: &mut Model, arg1: 0x1::string::String, arg2: u64, arg3: u64) {
        assert!(arg0.state == 0, 1021);
        let v0 = arg0.current_graph_idx;
        assert!(v0 < 0x1::vector::length<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(&arg0.graphs), 1018);
        0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::add_layer(0x1::vector::borrow_mut<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(&mut arg0.graphs, v0), 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::new_layer(arg1, arg2, arg3, 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), arg0.scale));
        arg0.current_layer_idx = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::get_layer_count(0x1::vector::borrow<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph::Graph>(&arg0.graphs, v0)) - 1;
        let v1 = LayerStarted{
            model_id      : 0x2::object::id_address<Model>(arg0),
            graph_idx     : v0,
            layer_idx     : arg0.current_layer_idx,
            in_dimension  : arg2,
            out_dimension : arg3,
        };
        0x2::event::emit<LayerStarted>(v1);
    }

    // decompiled from Move bytecode v6
}

