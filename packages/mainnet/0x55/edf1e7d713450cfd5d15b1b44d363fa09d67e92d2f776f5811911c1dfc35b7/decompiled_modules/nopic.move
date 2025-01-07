module 0x55edf1e7d713450cfd5d15b1b44d363fa09d67e92d2f776f5811911c1dfc35b7::nopic {
    struct NOPIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOPIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOPIC>(arg0, 6, b"Nopic", b"NO PIC", b"no photo. code : 0101010101010101", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dubo_fwog_gm_c2b83d7cf9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOPIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOPIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

