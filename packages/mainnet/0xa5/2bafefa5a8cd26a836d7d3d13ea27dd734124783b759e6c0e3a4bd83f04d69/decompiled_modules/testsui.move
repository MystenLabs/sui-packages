module 0xa52bafefa5a8cd26a836d7d3d13ea27dd734124783b759e6c0e3a4bd83f04d69::testsui {
    struct TESTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTSUI>(arg0, 6, b"TESTSUI", b"test_sui", b"test sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_c07df05f00_0eae6a18ed.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

