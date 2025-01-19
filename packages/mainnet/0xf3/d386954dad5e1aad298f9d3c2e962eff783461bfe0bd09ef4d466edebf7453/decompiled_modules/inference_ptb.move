module 0xf3d386954dad5e1aad298f9d3c2e962eff783461bfe0bd09ef4d466edebf7453::inference_ptb {
    struct Result has copy, drop {
        value: u64,
    }

    public entry fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf3d386954dad5e1aad298f9d3c2e962eff783461bfe0bd09ef4d466edebf7453::graph_ptb::create_signed_graph(arg0);
        0xf3d386954dad5e1aad298f9d3c2e962eff783461bfe0bd09ef4d466edebf7453::model_ptb::create_model_signed_fixed(&mut v0, 2);
        let v1 = 0xf3d386954dad5e1aad298f9d3c2e962eff783461bfe0bd09ef4d466edebf7453::model_ptb::create_partial_denses(arg0);
        0xf3d386954dad5e1aad298f9d3c2e962eff783461bfe0bd09ef4d466edebf7453::model_ptb::add_partials_for_all_but_last(&v0, &mut v1);
        0xf3d386954dad5e1aad298f9d3c2e962eff783461bfe0bd09ef4d466edebf7453::graph_ptb::share_graph(v0);
        0xf3d386954dad5e1aad298f9d3c2e962eff783461bfe0bd09ef4d466edebf7453::model_ptb::share_partial(v1);
    }

    fun test_check2() {
        let v0 = 0x1::string::utf8(b"true label: 8");
        0x1::debug::print<0x1::string::String>(&v0);
    }

    public entry fun test_inference(arg0: &0xf3d386954dad5e1aad298f9d3c2e962eff783461bfe0bd09ef4d466edebf7453::graph_ptb::SignedFixedGraph, arg1: &mut 0xf3d386954dad5e1aad298f9d3c2e962eff783461bfe0bd09ef4d466edebf7453::model_ptb::PartialDenses) {
        let v0 = 0x1::string::utf8(b"true label: 8");
        0x1::debug::print<0x1::string::String>(&v0);
        let v1 = vector[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 44, 30, 37, 0, 0, 0, 50, 3, 89, 0, 0, 0, 0, 0, 99, 5, 0, 0, 0, 0, 63, 5, 46, 0, 0, 0, 0, 97, 85, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        let v2 = vector[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        0xf3d386954dad5e1aad298f9d3c2e962eff783461bfe0bd09ef4d466edebf7453::model_ptb::ptb_graph_compute_chunk(arg0, arg1, b"dense1", v1, v2, 0, 7);
        0xf3d386954dad5e1aad298f9d3c2e962eff783461bfe0bd09ef4d466edebf7453::model_ptb::ptb_graph_compute_chunk(arg0, arg1, b"dense1", v1, v2, 8, 15);
        let (v3, v4, v5) = 0xf3d386954dad5e1aad298f9d3c2e962eff783461bfe0bd09ef4d466edebf7453::model_ptb::ptb_graph_finalize(arg0, arg1, b"dense1");
        let (v6, v7, v8) = 0xf3d386954dad5e1aad298f9d3c2e962eff783461bfe0bd09ef4d466edebf7453::model_ptb::ptb_graph_2(arg0, v3, v4, v5);
        let v9 = 0xf3d386954dad5e1aad298f9d3c2e962eff783461bfe0bd09ef4d466edebf7453::model_ptb::ptb_graph_3(arg0, v6, v7, v8);
        let v10 = 0x1::string::utf8(b"predicted label: ");
        0x1::debug::print<0x1::string::String>(&v10);
        0x1::debug::print<u64>(&v9);
    }

    // decompiled from Move bytecode v6
}

