module 0xe828fad8a032970f875b16351380972bc045f3a09b1d9c01f9cf07ce4f40b0b0::cock {
    struct COCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCK>(arg0, 6, b"Cock", b"CockAI", b"Reign through Artificial Intelligence", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/84_AB_5_CE_9_1_A41_433_B_8_A5_D_CD_3_C16_E64_C17_13b8abdbdc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

