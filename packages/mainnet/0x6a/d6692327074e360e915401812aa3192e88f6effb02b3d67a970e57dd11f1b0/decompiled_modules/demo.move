module 0x6ad6692327074e360e915401812aa3192e88f6effb02b3d67a970e57dd11f1b0::demo {
    struct DemoNFT has store, key {
        id: 0x2::object::UID,
    }

    struct DemoWitness has drop {
        dummy_field: bool,
    }

    struct NestedDemoWitness<phantom T0: drop> has drop {
        dummy_field: bool,
    }

    public fun new_nft(arg0: &mut 0x2::tx_context::TxContext) : DemoNFT {
        DemoNFT{id: 0x2::object::new(arg0)}
    }

    public fun noop_w_type_param<T0: drop>() {
    }

    // decompiled from Move bytecode v6
}

