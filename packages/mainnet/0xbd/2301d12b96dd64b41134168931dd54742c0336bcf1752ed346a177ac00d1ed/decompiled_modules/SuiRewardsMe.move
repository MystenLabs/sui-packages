module 0xbd2301d12b96dd64b41134168931dd54742c0336bcf1752ed346a177ac00d1ed::SuiRewardsMe {
    struct SUIREWARDSME has drop {
        dummy_field: bool,
    }

    struct CapGraveyard has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<SUIREWARDSME>,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIREWARDSME>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIREWARDSME>>(0x2::coin::mint<SUIREWARDSME>(arg0, arg1, arg3), arg2);
    }

    public entry fun bury_cap(arg0: 0x2::coin::TreasuryCap<SUIREWARDSME>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CapGraveyard{
            id  : 0x2::object::new(arg1),
            cap : arg0,
        };
        0x2::transfer::public_share_object<CapGraveyard>(v0);
    }

    fun init(arg0: SUIREWARDSME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIREWARDSME>(arg0, 9, b"SRM", b"SuiRewards.Me", b"It's time you got a piece!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeif5r3biiwsylqsjkkwh4yrsbltbeetq5w3snuodcw56b7iaaglxoa.ipfs.w3s.link/logo_blk.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIREWARDSME>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIREWARDSME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

