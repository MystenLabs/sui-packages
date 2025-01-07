module 0x3872b8acbde6d7ebe96f96322c1aab624abb18531610c4e1a6020006a6a644c5::dono {
    struct DONO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONO>(arg0, 6, b"DONO", b"dono", b"Its not a cat, its not a dog. Its just a nose.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dono_c5b9db42fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONO>>(v1);
    }

    // decompiled from Move bytecode v6
}

