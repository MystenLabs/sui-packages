module 0x8e2aac8520bd0871000f5510aa26ac6918b78fb92555794326bc34bbcfb065fd::demo {
    struct DemoNFT has store, key {
        id: 0x2::object::UID,
    }

    struct DemoWitness has drop {
        dummy_field: bool,
    }

    struct NestedDemoWitness<T0: drop> has drop {
        dummy_field: bool,
    }

    public fun new_nft(arg0: &mut 0x2::tx_context::TxContext) : DemoNFT {
        DemoNFT{id: 0x2::object::new(arg0)}
    }

    public fun noop_w_type_param<T0: drop>() {
    }

    // decompiled from Move bytecode v6
}

