module 0x1503f462bd39bd451e2e19e46ccdee0b90bc933b3a752dd6cdaf7a38d5231c43::sdragon {
    struct SDRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDRAGON>(arg0, 6, b"SDRAGON", b"Sui Dragon", b"In Dragon Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/92807b54_be6c_4c86_b1f2_89af518ebf8f_85a879213e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDRAGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDRAGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

