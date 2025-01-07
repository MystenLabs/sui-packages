module 0x4adc49be609166d56b6ac4f814e89b985893a46150b357a0fbfcb01146f14f1e::chepe {
    struct CHEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEPE>(arg0, 6, b"CHEPE", b"ChadPepe", x"4368616420506570652028244348455045290a5768656e20796f7520636f6d62696e65204368616420616e6420506570652c20796f75206765742043484550452074686520756c74696d617465206d656d65206f6e20636861642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/111_1921597d25.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

