module 0xed9af76a6f3e32ed96bf7eab111ccad155adb88860734d41c1dd9d16ee178b6d::suieep {
    struct SUIEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEEP>(arg0, 6, b"SUIEEP", b"SUIEEP on SUI", b"Sui is going to SUIEEP all the competition!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0a1e31ae_3811_42ef_a570_55f58da23833_5295fb0fd7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

