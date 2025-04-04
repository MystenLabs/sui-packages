module 0x9b8a82822335e9c5a4379f7752ec017afdf9127a34024bdc0e672264b947d237::mock_sui {
    struct MOCK_SUI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOCK_SUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOCK_SUI>>(0x2::coin::mint<MOCK_SUI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOCK_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCK_SUI>(arg0, 9, b"MOCKSUI", b"MockSui.Me", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeif5r3biiwsylqsjkkwh4yrsbltbeetq5w3snuodcw56b7iaaglxoa.ipfs.w3s.link/logo_blk.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOCK_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCK_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

