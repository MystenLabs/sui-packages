module 0x734deae72750887dfd58e643220d4310ca3aba1a361b79fd0b3c68f2e87b82b2::soul {
    struct SOUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOUL>(arg0, 6, b"SOUL", b"Pepes Soul", b"Buy Pepes $SOUL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C98_A7_ACC_242_F_401_F_8_AA_6_76705_E682_B13_5cdc4e8b2f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

