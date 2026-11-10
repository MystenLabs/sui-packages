module 0xe71005fc37e8843934e64aa5c4702a6c297e21e2f230f2225053182ee47b8de3::testsui {
    struct TESTSUI has key {
        id: 0x2::object::UID,
    }

    struct ShareCreatorCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create_share(arg0: ShareCreatorCap, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<TESTSUI>, 0x2::coin_registry::MetadataCap<TESTSUI>) {
        let (v0, v1) = 0x2::coin_registry::new_currency<TESTSUI>(arg1, 9, 0x1::string::utf8(b"testSUI"), 0x1::string::utf8(b"Test SUI"), 0x1::string::utf8(b"Test deposit asset for Upshift test vaults. No value."), 0x1::string::utf8(b""), arg2);
        let ShareCreatorCap { id: v2 } = arg0;
        0x2::object::delete(v2);
        (v1, 0x2::coin_registry::finalize<TESTSUI>(v0, arg2))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ShareCreatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<ShareCreatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

