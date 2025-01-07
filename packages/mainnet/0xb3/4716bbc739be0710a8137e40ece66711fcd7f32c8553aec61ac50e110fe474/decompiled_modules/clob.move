module 0xb34716bbc739be0710a8137e40ece66711fcd7f32c8553aec61ac50e110fe474::clob {
    struct CLOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOB>(arg0, 6, b"Clob", b"CLOB", b"Clob is king", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0417_3c01f69d87.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

