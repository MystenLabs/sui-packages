module 0x15db7fc27e798491b9cef5d5e477f7870ecc04c279475f88531d0517881d6645::inference_ptb {
    struct Result has copy, drop {
        value: u64,
    }

    public entry fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x15db7fc27e798491b9cef5d5e477f7870ecc04c279475f88531d0517881d6645::graph_ptb::create_signed_graph(arg0);
        0x15db7fc27e798491b9cef5d5e477f7870ecc04c279475f88531d0517881d6645::model_ptb::create_model_signed_fixed(&mut v0, 2);
        let v1 = 0x15db7fc27e798491b9cef5d5e477f7870ecc04c279475f88531d0517881d6645::model_ptb::create_partial_denses(arg0);
        0x15db7fc27e798491b9cef5d5e477f7870ecc04c279475f88531d0517881d6645::model_ptb::add_partials_for_all_but_last(&v0, &mut v1);
        0x15db7fc27e798491b9cef5d5e477f7870ecc04c279475f88531d0517881d6645::graph_ptb::share_graph(v0);
        0x15db7fc27e798491b9cef5d5e477f7870ecc04c279475f88531d0517881d6645::model_ptb::share_partial(v1);
    }

    fun test_check2() {
        let v0 = 0x1::string::utf8(b"true label: 8");
        0x1::debug::print<0x1::string::String>(&v0);
    }

    public entry fun test_inference(arg0: &0x15db7fc27e798491b9cef5d5e477f7870ecc04c279475f88531d0517881d6645::graph_ptb::SignedFixedGraph, arg1: &mut 0x15db7fc27e798491b9cef5d5e477f7870ecc04c279475f88531d0517881d6645::model_ptb::PartialDenses) {
        let v0 = 0x1::string::utf8(b"true label: 8");
        0x1::debug::print<0x1::string::String>(&v0);
    }

    // decompiled from Move bytecode v6
}

