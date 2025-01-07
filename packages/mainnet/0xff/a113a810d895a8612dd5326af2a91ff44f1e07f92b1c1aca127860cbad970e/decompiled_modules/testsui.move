module 0xffa113a810d895a8612dd5326af2a91ff44f1e07f92b1c1aca127860cbad970e::testsui {
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

