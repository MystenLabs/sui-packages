module 0x1d1394c5dfe80f8bc75e3b98ce4b63b67ce27eb790d6dde5969b071a1312f1d5::kinji {
    struct KINJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINJI>(arg0, 6, b"Kinji", b"Kinji Token", b"$KENJI Is Bringing Utility And Fun Back To SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_Ya_Bg_A_N_400x400_e2c8ff59bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

