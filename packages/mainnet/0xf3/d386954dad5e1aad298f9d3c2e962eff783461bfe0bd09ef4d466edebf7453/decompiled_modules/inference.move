module 0xf3d386954dad5e1aad298f9d3c2e962eff783461bfe0bd09ef4d466edebf7453::inference {
    struct Result has copy, drop {
        value: u64,
    }

    public entry fun run(arg0: vector<u64>, arg1: vector<u64>, arg2: u64) {
        let v0 = 0xf3d386954dad5e1aad298f9d3c2e962eff783461bfe0bd09ef4d466edebf7453::graph::create_signed_graph();
        0xf3d386954dad5e1aad298f9d3c2e962eff783461bfe0bd09ef4d466edebf7453::model::create_model_signed_fixed(&mut v0, arg2);
        let v1 = 0xf3d386954dad5e1aad298f9d3c2e962eff783461bfe0bd09ef4d466edebf7453::tensor::from_input(vector[1, 49], arg0, arg1, arg2);
        let v2 = 0x1::string::utf8(b"[fixed] input tensor: ");
        0x1::debug::print<0x1::string::String>(&v2);
        0xf3d386954dad5e1aad298f9d3c2e962eff783461bfe0bd09ef4d466edebf7453::tensor::debug_print_tensor(&v1);
        let v3 = 0xf3d386954dad5e1aad298f9d3c2e962eff783461bfe0bd09ef4d466edebf7453::model::run_inference_signed_fixed(&v1, &v0);
        let v4 = 0xf3d386954dad5e1aad298f9d3c2e962eff783461bfe0bd09ef4d466edebf7453::tensor::argmax(&v3);
        let v5 = 0x1::string::utf8(b"[fixed] output tensor: ");
        0x1::debug::print<0x1::string::String>(&v5);
        0xf3d386954dad5e1aad298f9d3c2e962eff783461bfe0bd09ef4d466edebf7453::tensor::debug_print_tensor(&v3);
        let v6 = 0x1::string::utf8(b"y label: ");
        0x1::debug::print<0x1::string::String>(&v6);
        0x1::debug::print<u64>(&v4);
        let v7 = Result{value: v4};
        0x2::event::emit<Result>(v7);
    }

    fun test_check2() {
        let v0 = 0x1::string::utf8(b"true label: 8");
        0x1::debug::print<0x1::string::String>(&v0);
        run(vector[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 44, 30, 37, 0, 0, 0, 50, 3, 89, 0, 0, 0, 0, 0, 99, 5, 0, 0, 0, 0, 63, 5, 46, 0, 0, 0, 0, 97, 85, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], vector[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 2);
    }

    // decompiled from Move bytecode v6
}

