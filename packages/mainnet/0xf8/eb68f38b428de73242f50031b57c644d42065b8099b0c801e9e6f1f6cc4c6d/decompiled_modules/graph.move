module 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::graph {
    struct Result_arg has copy, drop {
        value: u64,
    }

    struct SignedFixedLayer has copy, drop, store {
        name: vector<u8>,
        layer_type: vector<u8>,
        in_dim: u64,
        out_dim: u64,
        weight_tensor: 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::SignedFixedTensor,
        bias_tensor: 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::SignedFixedTensor,
    }

    struct SignedFixedGraph has store, key {
        id: 0x2::object::UID,
        layers: vector<SignedFixedLayer>,
    }

    struct Layer has copy, drop {
        name: vector<u8>,
        layer_type: vector<u8>,
        input_nodes: u64,
        output_nodes: u64,
        weights: vector<u64>,
        bias: vector<u64>,
    }

    struct Graph has drop {
        layers: vector<Layer>,
    }

    struct PartialDense has copy, drop, store {
        name: vector<u8>,
        accum_mag: vector<u64>,
        accum_sign: vector<u64>,
        out_dim: u64,
        in_dim: u64,
        scale: u64,
    }

    struct PartialDenses has store, key {
        id: 0x2::object::UID,
        partials: vector<PartialDense>,
    }

    public fun Dense(arg0: &mut Graph, arg1: u64, arg2: u64, arg3: vector<u8>) : Layer {
        let v0 = Layer{
            name         : arg3,
            layer_type   : b"dense",
            input_nodes  : arg1,
            output_nodes : arg2,
            weights      : initialize_weights(arg1, arg2),
            bias         : initialize_bias(arg2),
        };
        0x1::vector::push_back<Layer>(&mut arg0.layers, v0);
        v0
    }

    public fun DenseSignedFixed(arg0: &mut SignedFixedGraph, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: u64) : SignedFixedLayer {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < arg1 * arg2) {
            0x1::vector::push_back<u64>(&mut v0, 1);
            0x1::vector::push_back<u64>(&mut v1, 0);
            v2 = v2 + 1;
        };
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, arg1);
        0x1::vector::push_back<u64>(v4, arg2);
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0;
        while (v7 < arg2) {
            0x1::vector::push_back<u64>(&mut v5, 0);
            0x1::vector::push_back<u64>(&mut v6, 0);
            v7 = v7 + 1;
        };
        let v8 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v8, arg2);
        let v9 = SignedFixedLayer{
            name          : arg3,
            layer_type    : b"dense_sf",
            in_dim        : arg1,
            out_dim       : arg2,
            weight_tensor : 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::create_signed_fixed(v3, v0, v1, arg4),
            bias_tensor   : 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::create_signed_fixed(v8, v5, v6, arg4),
        };
        0x1::vector::push_back<SignedFixedLayer>(&mut arg0.layers, v9);
        v9
    }

    public fun Input(arg0: &mut Graph, arg1: vector<u8>) : Layer {
        let v0 = Layer{
            name         : arg1,
            layer_type   : b"input",
            input_nodes  : 0,
            output_nodes : 0,
            weights      : 0x1::vector::empty<u64>(),
            bias         : 0x1::vector::empty<u64>(),
        };
        0x1::vector::push_back<Layer>(&mut arg0.layers, v0);
        v0
    }

    public fun ReLu(arg0: u64) : u64 {
        if (arg0 > 0) {
            arg0
        } else {
            0
        }
    }

    public fun add_layer(arg0: &mut Graph, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64) {
        let v0 = Layer{
            name         : arg1,
            layer_type   : arg2,
            input_nodes  : arg3,
            output_nodes : arg4,
            weights      : initialize_weights(arg3, arg4),
            bias         : initialize_bias(arg4),
        };
        0x1::vector::push_back<Layer>(&mut arg0.layers, v0);
    }

    public entry fun add_partial_for_layer(arg0: &SignedFixedGraph, arg1: u64, arg2: &mut PartialDenses) {
        let v0 = get_layer_at(arg0, arg1);
        let v1 = get_layer_out_dim(v0);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        while (v4 < v1) {
            0x1::vector::push_back<u64>(&mut v2, 0);
            0x1::vector::push_back<u64>(&mut v3, 0);
            v4 = v4 + 1;
        };
        let v5 = PartialDense{
            name       : get_layer_name(v0),
            accum_mag  : v2,
            accum_sign : v3,
            out_dim    : v1,
            in_dim     : get_layer_in_dim(v0),
            scale      : 2,
        };
        0x1::vector::push_back<PartialDense>(&mut arg2.partials, v5);
    }

    public fun add_partials_for_all_but_last(arg0: &SignedFixedGraph, arg1: &mut PartialDenses) {
        let v0 = 0;
        while (v0 < get_layer_count(arg0) - 1) {
            add_partial_for_layer(arg0, v0, arg1);
            v0 = v0 + 1;
        };
    }

    public fun apply_conv2d(arg0: vector<u64>, arg1: &vector<u64>, arg2: u64) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::length<u64>(arg1);
        let v2 = 0;
        while (v2 <= 0x1::vector::length<u64>(&arg0) - v1) {
            let v3 = 0;
            let v4 = 0;
            while (v4 < v1) {
                v3 = v3 + *0x1::vector::borrow<u64>(&arg0, v2 + v4) * *0x1::vector::borrow<u64>(arg1, v4);
                v4 = v4 + 1;
            };
            0x1::vector::push_back<u64>(&mut v0, v3 + arg2);
            v2 = v2 + 1;
        };
        v0
    }

    public fun apply_dense(arg0: vector<u64>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: u64) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::length<u64>(&arg0);
        let v2 = v1 * arg3;
        let v3 = 0x1::string::utf8(b"input vector:");
        0x1::debug::print<0x1::string::String>(&v3);
        0x1::debug::print<vector<u64>>(&arg0);
        let v4 = 0x1::string::utf8(b"input number:");
        0x1::debug::print<0x1::string::String>(&v4);
        0x1::debug::print<u64>(&v1);
        let v5 = 0x1::string::utf8(b"output number:");
        0x1::debug::print<0x1::string::String>(&v5);
        0x1::debug::print<u64>(&arg3);
        let v6 = 0x1::string::utf8(b"max computation:");
        0x1::debug::print<0x1::string::String>(&v6);
        0x1::debug::print<u64>(&v2);
        0x1::debug::print<vector<u64>>(arg1);
        0x1::debug::print<vector<u64>>(arg2);
        0x1::debug::print<u64>(&arg3);
        let v7 = 0;
        while (v7 < arg3) {
            let v8 = 0;
            let v9 = 0;
            while (v9 < v1) {
                let v10 = v7 * v1 + v9;
                let v11 = 0x1::string::utf8(b"i number:");
                0x1::debug::print<0x1::string::String>(&v11);
                0x1::debug::print<u64>(&v7);
                let v12 = 0x1::string::utf8(b"j number:");
                0x1::debug::print<0x1::string::String>(&v12);
                0x1::debug::print<u64>(&v9);
                let v13 = 0x1::string::utf8(b"weigth_index:");
                0x1::debug::print<0x1::string::String>(&v13);
                0x1::debug::print<u64>(&v10);
                v8 = v8 + *0x1::vector::borrow<u64>(&arg0, v9) * *0x1::vector::borrow<u64>(arg1, v10);
                v9 = v9 + 1;
            };
            0x1::vector::push_back<u64>(&mut v0, ReLu(v8 + *0x1::vector::borrow<u64>(arg2, v7)));
            v7 = v7 + 1;
        };
        v0
    }

    public fun apply_dense_signed_fixed(arg0: &0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::SignedFixedTensor, arg1: &0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::SignedFixedTensor, arg2: &0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::SignedFixedTensor) : 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::SignedFixedTensor {
        let v0 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_shape(arg0);
        let v1 = *0x1::vector::borrow<u64>(&v0, 0);
        let v2 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_shape(arg0);
        let v3 = *0x1::vector::borrow<u64>(&v2, 1);
        let v4 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_shape(arg1);
        let v5 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_shape(arg1);
        let v6 = *0x1::vector::borrow<u64>(&v5, 1);
        let v7 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_shape(arg2);
        assert!(v3 == *0x1::vector::borrow<u64>(&v4, 0), 10001);
        assert!(v6 == *0x1::vector::borrow<u64>(&v7, 0), 10002);
        let v8 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_scale(arg0);
        assert!(v8 == 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_scale(arg1), 10003);
        assert!(v8 == 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_scale(arg2), 10004);
        let v9 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v9, v1);
        0x1::vector::push_back<u64>(&mut v9, v6);
        let v10 = 0x1::vector::empty<u64>();
        let v11 = 0x1::vector::empty<u64>();
        let v12 = 0;
        while (v12 < v1) {
            let v13 = 0;
            while (v13 < v6) {
                let v14 = 0;
                let v15 = 0;
                let v16 = 0;
                while (v16 < v3) {
                    let v17 = v12 * v3 + v16;
                    let v18 = v16 * v6 + v13;
                    let v19 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_sign(arg0);
                    let v20 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_magnitude(arg0);
                    let v21 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_sign(arg1);
                    let v22 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_magnitude(arg1);
                    let v23 = if (*0x1::vector::borrow<u64>(&v19, v17) == *0x1::vector::borrow<u64>(&v21, v18)) {
                        0
                    } else {
                        1
                    };
                    let (v24, v25) = signed_add_element(v14, v15, v23, *0x1::vector::borrow<u64>(&v20, v17) * *0x1::vector::borrow<u64>(&v22, v18));
                    v14 = v24;
                    v15 = v25;
                    v16 = v16 + 1;
                };
                let v26 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_sign(arg2);
                let v27 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_magnitude(arg2);
                let (v28, v29) = signed_add_element(v14, v15, *0x1::vector::borrow<u64>(&v26, v13), *0x1::vector::borrow<u64>(&v27, v13) * 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::scale_up(1, v8));
                let v30 = v28;
                let v31 = v29;
                if (v28 == 1) {
                    v30 = 0;
                    v31 = 0;
                };
                0x1::vector::push_back<u64>(&mut v11, v30);
                0x1::vector::push_back<u64>(&mut v10, v31 / 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::scale_up(1, v8));
                v13 = v13 + 1;
            };
            v12 = v12 + 1;
        };
        0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::create_signed_fixed(v9, v10, v11, v8)
    }

    public fun apply_dense_signed_fixed_2(arg0: &0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::SignedFixedTensor, arg1: &0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::SignedFixedTensor, arg2: &0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::SignedFixedTensor, arg3: u64) : 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::SignedFixedTensor {
        let v0 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_shape(arg0);
        let v1 = *0x1::vector::borrow<u64>(&v0, 0);
        let v2 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_shape(arg0);
        let v3 = *0x1::vector::borrow<u64>(&v2, 1);
        let v4 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_shape(arg1);
        let v5 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_shape(arg1);
        let v6 = *0x1::vector::borrow<u64>(&v5, 1);
        let v7 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_shape(arg2);
        assert!(v3 == *0x1::vector::borrow<u64>(&v4, 0), 10001);
        assert!(v6 == *0x1::vector::borrow<u64>(&v7, 0), 10002);
        let v8 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_scale(arg0);
        assert!(v8 == 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_scale(arg1), 10003);
        assert!(v8 == 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_scale(arg2), 10004);
        let v9 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v9, v1);
        0x1::vector::push_back<u64>(&mut v9, v6);
        let v10 = 0x1::vector::empty<u64>();
        let v11 = 0x1::vector::empty<u64>();
        let v12 = 0;
        while (v12 < v1) {
            let v13 = 0;
            while (v13 < v6) {
                let v14 = 0;
                let v15 = 0;
                let v16 = 0;
                while (v16 < v3) {
                    let v17 = v12 * v3 + v16;
                    let v18 = v16 * v6 + v13;
                    let v19 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_sign(arg0);
                    let v20 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_magnitude(arg0);
                    let v21 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_sign(arg1);
                    let v22 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_magnitude(arg1);
                    let v23 = if (*0x1::vector::borrow<u64>(&v19, v17) == *0x1::vector::borrow<u64>(&v21, v18)) {
                        0
                    } else {
                        1
                    };
                    let (v24, v25) = signed_add_element(v14, v15, v23, *0x1::vector::borrow<u64>(&v20, v17) * *0x1::vector::borrow<u64>(&v22, v18));
                    v14 = v24;
                    v15 = v25;
                    v16 = v16 + 1;
                };
                let v26 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_sign(arg2);
                let v27 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_magnitude(arg2);
                let (v28, v29) = signed_add_element(v14, v15, *0x1::vector::borrow<u64>(&v26, v13), *0x1::vector::borrow<u64>(&v27, v13) * 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::scale_up(1, v8));
                let (v30, v31) = if (arg3 == 1) {
                    apply_relu_element(v28, v29)
                } else {
                    (v28, v29)
                };
                0x1::vector::push_back<u64>(&mut v11, v30);
                0x1::vector::push_back<u64>(&mut v10, v31 / 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::scale_up(1, v8));
                v13 = v13 + 1;
            };
            v12 = v12 + 1;
        };
        0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::create_signed_fixed(v9, v10, v11, v8)
    }

    fun apply_relu_element(arg0: u64, arg1: u64) : (u64, u64) {
        if (arg0 == 1) {
            (0, 0)
        } else {
            (arg0, arg1)
        }
    }

    public fun create() : Graph {
        Graph{layers: 0x1::vector::empty<Layer>()}
    }

    public fun create_partial_denses(arg0: &mut 0x2::tx_context::TxContext) : PartialDenses {
        PartialDenses{
            id       : 0x2::object::new(arg0),
            partials : 0x1::vector::empty<PartialDense>(),
        }
    }

    public fun create_signed_graph(arg0: &mut 0x2::tx_context::TxContext) : SignedFixedGraph {
        SignedFixedGraph{
            id     : 0x2::object::new(arg0),
            layers : 0x1::vector::empty<SignedFixedLayer>(),
        }
    }

    public fun get_bias(arg0: &Layer) : vector<u64> {
        arg0.bias
    }

    public fun get_bias_tensor(arg0: &SignedFixedLayer) : &0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::SignedFixedTensor {
        &arg0.bias_tensor
    }

    public fun get_layer(arg0: &Graph, arg1: vector<u8>) : &Layer {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Layer>(&arg0.layers)) {
            let v1 = 0x1::vector::borrow<Layer>(&arg0.layers, v0);
            if (v1.name == arg1) {
                return v1
            };
            v0 = v0 + 1;
        };
        abort 1
    }

    public fun get_layer_at(arg0: &SignedFixedGraph, arg1: u64) : &SignedFixedLayer {
        0x1::vector::borrow<SignedFixedLayer>(&arg0.layers, arg1)
    }

    public fun get_layer_count(arg0: &SignedFixedGraph) : u64 {
        0x1::vector::length<SignedFixedLayer>(&arg0.layers)
    }

    public fun get_layer_in_dim(arg0: &SignedFixedLayer) : u64 {
        arg0.in_dim
    }

    public fun get_layer_name(arg0: &SignedFixedLayer) : vector<u8> {
        arg0.name
    }

    public fun get_layer_out_dim(arg0: &SignedFixedLayer) : u64 {
        arg0.out_dim
    }

    public fun get_layer_signed_fixed(arg0: &SignedFixedGraph, arg1: vector<u8>) : &SignedFixedLayer {
        let v0 = 0;
        while (v0 < 0x1::vector::length<SignedFixedLayer>(&arg0.layers)) {
            let v1 = 0x1::vector::borrow<SignedFixedLayer>(&arg0.layers, v0);
            if (v1.name == arg1) {
                return v1
            };
            v0 = v0 + 1;
        };
        abort 9999
    }

    public fun get_layer_type(arg0: &Layer) : &vector<u8> {
        &arg0.layer_type
    }

    public fun get_name(arg0: &Layer) : &vector<u8> {
        &arg0.name
    }

    public fun get_output_nodes(arg0: &Layer) : u64 {
        arg0.output_nodes
    }

    public fun get_partial_by_name_mut(arg0: &mut PartialDenses, arg1: vector<u8>) : &mut PartialDense {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PartialDense>(&arg0.partials)) {
            let v1 = 0x1::vector::borrow_mut<PartialDense>(&mut arg0.partials, v0);
            if (v1.name == arg1) {
                return v1
            };
            v0 = v0 + 1;
        };
        abort 9999
    }

    public fun get_weight_tensor(arg0: &SignedFixedLayer) : &0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::SignedFixedTensor {
        &arg0.weight_tensor
    }

    public fun get_weights(arg0: &Layer) : vector<u64> {
        arg0.weights
    }

    public entry fun init_partials(arg0: &SignedFixedGraph, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_partial_denses(arg1);
        let v1 = &mut v0;
        add_partials_for_all_but_last(arg0, v1);
        share_partial(v0);
    }

    public fun initialize_bias(arg0: u64) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    public fun initialize_weights(arg0: u64, arg1: u64) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < arg0 * arg1) {
            0x1::vector::push_back<u64>(&mut v0, 1);
            v1 = v1 + 1;
        };
        v0
    }

    public fun ptb_graph_2_compute_chunk(arg0: &SignedFixedGraph, arg1: &mut PartialDenses, arg2: vector<u8>, arg3: &0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::SignedFixedTensor, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = get_partial_by_name_mut(arg1, arg2);
        let v1 = get_layer_signed_fixed(arg0, arg2);
        let v2 = get_weight_tensor(v1);
        let v3 = get_bias_tensor(v1);
        let v4 = v0.out_dim;
        let v5 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_scale(arg3);
        let v6 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_shape(arg3);
        let v7 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_shape(arg3);
        let v8 = *0x1::vector::borrow<u64>(&v7, 1);
        let v9 = &mut v0.accum_mag;
        let v10 = &mut v0.accum_sign;
        assert!(arg6 <= v4, 9999);
        let v11 = 0;
        while (v11 < *0x1::vector::borrow<u64>(&v6, 0)) {
            while (arg5 <= arg6) {
                let v12 = v11 * v4 + arg5;
                let v13 = 0;
                let v14 = 0;
                let v15 = 0;
                while (v15 < v8) {
                    let v16 = v11 * v8 + v15;
                    let v17 = v15 * v4 + arg5;
                    let v18 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_sign(arg3);
                    let v19 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_magnitude(arg3);
                    let v20 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_sign(v2);
                    let v21 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_magnitude(v2);
                    let v22 = if (*0x1::vector::borrow<u64>(&v18, v16) == *0x1::vector::borrow<u64>(&v20, v17)) {
                        0
                    } else {
                        1
                    };
                    let (v23, v24) = signed_add_element(v13, v14, v22, *0x1::vector::borrow<u64>(&v19, v16) * *0x1::vector::borrow<u64>(&v21, v17));
                    v13 = v23;
                    v14 = v24;
                    v15 = v15 + 1;
                };
                let v25 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_sign(v3);
                let v26 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_magnitude(v3);
                let (v27, v28) = signed_add_element(v13, v14, *0x1::vector::borrow<u64>(&v25, arg5), *0x1::vector::borrow<u64>(&v26, arg5) * 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::scale_up(1, v5));
                let (v29, v30) = if (arg4 == 1) {
                    apply_relu_element(v27, v28)
                } else {
                    (v27, v28)
                };
                *0x1::vector::borrow_mut<u64>(v10, v12) = v29;
                *0x1::vector::borrow_mut<u64>(v9, v12) = v30 / 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::scale_up(1, v5);
                arg5 = arg5 + 1;
            };
            v11 = v11 + 1;
        };
    }

    public entry fun ptb_graph_compute_chunk(arg0: &SignedFixedGraph, arg1: &mut PartialDenses, arg2: vector<u8>, arg3: vector<u64>, arg4: vector<u64>, arg5: u64, arg6: u64) {
        let v0 = get_partial_by_name_mut(arg1, arg2);
        let v1 = get_weight_tensor(get_layer_signed_fixed(arg0, arg2));
        let v2 = v0.out_dim;
        assert!(arg6 <= v2, 9999);
        let v3 = &mut v0.accum_mag;
        let v4 = &mut v0.accum_sign;
        while (arg5 <= arg6) {
            let v5 = *0x1::vector::borrow<u64>(v4, arg5);
            let v6 = *0x1::vector::borrow<u64>(v3, arg5);
            let v7 = 0;
            while (v7 < v0.in_dim) {
                let v8 = v7 * v2 + arg5;
                let v9 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_sign(v1);
                let v10 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_magnitude(v1);
                let v11 = if (*0x1::vector::borrow<u64>(&arg4, v7) == *0x1::vector::borrow<u64>(&v9, v8)) {
                    0
                } else {
                    1
                };
                let (v12, v13) = signed_add_element(v5, v6, v11, *0x1::vector::borrow<u64>(&arg3, v7) * *0x1::vector::borrow<u64>(&v10, v8));
                v5 = v12;
                v6 = v13;
                v7 = v7 + 1;
            };
            *0x1::vector::borrow_mut<u64>(v4, arg5) = v5;
            *0x1::vector::borrow_mut<u64>(v3, arg5) = v6;
            arg5 = arg5 + 1;
        };
    }

    public entry fun ptb_layer(arg0: &SignedFixedGraph, arg1: vector<u64>, arg2: vector<u64>, arg3: u64, arg4: vector<u8>) : (vector<u64>, vector<u64>, u64) {
        let v0 = get_layer_signed_fixed(arg0, arg4);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, 1);
        0x1::vector::push_back<u64>(v2, get_layer_in_dim(v0));
        let v3 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::from_input(v1, arg1, arg2, arg3);
        let v4 = apply_dense_signed_fixed_2(&v3, get_weight_tensor(v0), get_bias_tensor(v0), 1);
        (0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_magnitude(&v4), 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_sign(&v4), arg3)
    }

    public entry fun ptb_layer_arg_max(arg0: &SignedFixedGraph, arg1: vector<u64>, arg2: vector<u64>, arg3: u64, arg4: vector<u8>) : u64 {
        let v0 = get_layer_signed_fixed(arg0, arg4);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, 1);
        0x1::vector::push_back<u64>(v2, get_layer_in_dim(v0));
        let v3 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::from_input(v1, arg1, arg2, arg3);
        let v4 = apply_dense_signed_fixed_2(&v3, get_weight_tensor(v0), get_bias_tensor(v0), 1);
        let v5 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::argmax(&v4);
        let v6 = Result_arg{value: v5};
        0x2::event::emit<Result_arg>(v6);
        v5
    }

    public fun set_layer_weights(arg0: &mut Graph, arg1: vector<u8>, arg2: vector<u64>, arg3: vector<u64>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Layer>(&arg0.layers)) {
            let v1 = 0x1::vector::borrow_mut<Layer>(&mut arg0.layers, v0);
            if (v1.name == arg1) {
                v1.weights = arg2;
                v1.bias = arg3;
                return
            };
            v0 = v0 + 1;
        };
        abort 1
    }

    public fun set_layer_weights_signed_fixed(arg0: &mut SignedFixedGraph, arg1: vector<u8>, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<SignedFixedLayer>(&arg0.layers)) {
            let v1 = 0x1::vector::borrow_mut<SignedFixedLayer>(&mut arg0.layers, v0);
            if (v1.name == arg1) {
                let v2 = 0x1::vector::empty<u64>();
                let v3 = &mut v2;
                0x1::vector::push_back<u64>(v3, arg6);
                0x1::vector::push_back<u64>(v3, arg7);
                v1.weight_tensor = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::create_signed_fixed(v2, arg2, arg3, arg8);
                let v4 = 0x1::vector::empty<u64>();
                0x1::vector::push_back<u64>(&mut v4, arg7);
                v1.bias_tensor = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::create_signed_fixed(v4, arg4, arg5, arg8);
                return
            };
            v0 = v0 + 1;
        };
        abort 4444
    }

    public fun share_graph(arg0: SignedFixedGraph) {
        0x2::transfer::share_object<SignedFixedGraph>(arg0);
    }

    public fun share_partial(arg0: PartialDenses) {
        0x2::transfer::share_object<PartialDenses>(arg0);
    }

    fun signed_add_element(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        if (arg0 == arg2) {
            (arg0, arg1 + arg3)
        } else if (arg1 >= arg3) {
            (arg0, arg1 - arg3)
        } else {
            (arg2, arg3 - arg1)
        }
    }

    public entry fun split_chunk_compute(arg0: &SignedFixedGraph, arg1: &mut PartialDenses, arg2: vector<u8>, arg3: vector<u64>, arg4: vector<u64>, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = get_partial_by_name_mut(arg1, arg2);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, 1);
        0x1::vector::push_back<u64>(v2, v0.in_dim);
        let v3 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::from_input(v1, arg3, arg4, v0.scale);
        ptb_graph_2_compute_chunk(arg0, arg1, arg2, &v3, arg5, arg6, arg7);
    }

    public entry fun split_chunk_finalize(arg0: &mut PartialDenses, arg1: vector<u8>) : (vector<u64>, vector<u64>, u64) {
        let v0 = get_partial_by_name_mut(arg0, arg1);
        let v1 = v0.scale;
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, 1);
        0x1::vector::push_back<u64>(&mut v2, v0.out_dim);
        let v3 = 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::create_signed_fixed(v2, v0.accum_mag, v0.accum_sign, v1);
        (0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_magnitude(&v3), 0xf8eb68f38b428de73242f50031b57c644d42065b8099b0c801e9e6f1f6cc4c6d::tensor::get_sign(&v3), v1)
    }

    // decompiled from Move bytecode v6
}

