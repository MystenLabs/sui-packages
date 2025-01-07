module 0xe0b66b0cdfcb515e255881d74058816774b67b8d344004e8074c0ac08c4666de::agt {
    struct AGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGT>(arg0, 6, b"AGT", b"OurAgent", b"An Ai agent powered by you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735966448146.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

