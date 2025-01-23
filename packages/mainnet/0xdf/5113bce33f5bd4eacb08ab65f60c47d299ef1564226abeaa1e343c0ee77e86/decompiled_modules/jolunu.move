module 0xdf5113bce33f5bd4eacb08ab65f60c47d299ef1564226abeaa1e343c0ee77e86::jolunu {
    struct JOLUNU has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOLUNU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<JOLUNU>(arg0, 6, b"JOLUNU", b"Jolunu AI Token by SuiAI", b"JOLUNU AI is an advanced artificial intelligence designed to enhance the efficiency of asset purchases within the cryptocurrency ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/jolunufavico_9f9caba171.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOLUNU>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOLUNU>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

