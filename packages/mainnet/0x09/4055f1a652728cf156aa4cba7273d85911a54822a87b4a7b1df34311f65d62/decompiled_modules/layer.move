module 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer {
    struct Layer has copy, drop, store {
        layer_type: 0x1::string::String,
        in_dimension: u64,
        out_dimension: u64,
        weight_tensor: 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::tensor::Tensor,
        bias_tensor: 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::tensor::Tensor,
    }

    public fun ReLu(arg0: u64) : u64 {
        if (arg0 > 0) {
            arg0
        } else {
            0
        }
    }

    public fun add_biases_chunk(arg0: &mut Layer, arg1: u64, arg2: vector<u64>, arg3: vector<u64>) {
        let v0 = &mut arg0.bias_tensor;
        let v1 = arg0.out_dimension;
        assert!(arg1 < v1, 10005);
        assert!(arg1 + 0x1::vector::length<u64>(&arg2) <= v1, 10006);
        0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::tensor::update_values(v0, arg1, arg2, arg3);
    }

    public fun add_weights_chunk(arg0: &mut Layer, arg1: u64, arg2: vector<u64>, arg3: vector<u64>) {
        let v0 = &mut arg0.weight_tensor;
        let v1 = arg0.in_dimension * arg0.out_dimension;
        assert!(arg1 < v1, 10005);
        assert!(arg1 + 0x1::vector::length<u64>(&arg2) <= v1, 10006);
        0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::tensor::update_values(v0, arg1, arg2, arg3);
    }

    public fun get_bias_tensor(arg0: &Layer) : &0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::tensor::Tensor {
        &arg0.bias_tensor
    }

    public fun get_in_dimension(arg0: &Layer) : u64 {
        arg0.in_dimension
    }

    public fun get_out_dimension(arg0: &Layer) : u64 {
        arg0.out_dimension
    }

    public fun get_weight_tensor(arg0: &Layer) : &0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::tensor::Tensor {
        &arg0.weight_tensor
    }

    public fun new_layer(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: u64) : Layer {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg1);
        0x1::vector::push_back<u64>(v1, arg2);
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, arg2);
        Layer{
            layer_type    : arg0,
            in_dimension  : arg1,
            out_dimension : arg2,
            weight_tensor : 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::tensor::new_tensor(v0, arg3, arg4, arg7),
            bias_tensor   : 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::tensor::new_tensor(v2, arg5, arg6, arg7),
        }
    }

    // decompiled from Move bytecode v6
}

