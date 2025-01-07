module 0x48230f9482153a056e6ad4829109d2c8ab659fe2d9068e536ce1d496e15a64b8::bird {
    struct BIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRD>(arg0, 6, b"BIRD", b"Birb", b"FWOG emerged and brought BIRB, a Yellow and cute BIRB, more based BIRB, a BIRBED one. BIRB it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_16_22_45_19_2743bc4f1c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

