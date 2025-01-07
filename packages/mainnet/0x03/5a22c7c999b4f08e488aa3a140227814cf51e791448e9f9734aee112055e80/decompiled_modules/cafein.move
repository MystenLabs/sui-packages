module 0x35a22c7c999b4f08e488aa3a140227814cf51e791448e9f9734aee112055e80::cafein {
    struct CAFEIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAFEIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAFEIN>(arg0, 9, b"CAFEIN", b"Cafein", x"456e6a6f7920796f7572206361666520e29895207769746820f09faa9943414645494e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/71c6d5b5-46ff-43c2-b59f-dcbd3be48797.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAFEIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAFEIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

