module 0x3534be8d9e2668e511039582791c519aa659ecdfa1e9c3455a921ed496d55038::toto34 {
    struct TOTO34 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOTO34, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<TOTO34>(arg0, 6, b"TOTO34", b"TOTO", b"asdasdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fewcha_1d5ea0d29f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOTO34>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<TOTO34>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOTO34>>(v2);
    }

    // decompiled from Move bytecode v6
}

