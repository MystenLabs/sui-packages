module 0x1b66fa93fd9f314f966c7bb20139e2f20669a24bec59fdb8f352357dcc04164a::uptestsui {
    struct UPTESTSUI has key {
        id: 0x2::object::UID,
    }

    struct ShareCreatorCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create_share(arg0: ShareCreatorCap, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<UPTESTSUI>, 0x2::coin_registry::MetadataCap<UPTESTSUI>) {
        let (v0, v1) = 0x2::coin_registry::new_currency<UPTESTSUI>(arg1, 9, 0x1::string::utf8(b"UPTESTSUI"), 0x1::string::utf8(b"Upshift testSUI Share"), 0x1::string::utf8(b"Share of the Upshift test vault for testSUI"), 0x1::string::utf8(b""), arg2);
        let ShareCreatorCap { id: v2 } = arg0;
        0x2::object::delete(v2);
        (v1, 0x2::coin_registry::finalize<UPTESTSUI>(v0, arg2))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ShareCreatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<ShareCreatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

