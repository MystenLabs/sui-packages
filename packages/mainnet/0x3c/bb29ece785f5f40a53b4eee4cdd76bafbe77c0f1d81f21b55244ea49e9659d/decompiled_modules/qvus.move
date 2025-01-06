module 0x3cbb29ece785f5f40a53b4eee4cdd76bafbe77c0f1d81f21b55244ea49e9659d::qvus {
    struct QVUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: QVUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<QVUS>(arg0, 6, b"QVUS", b"QUANTIVUS by SuiAI", x"496e2074686520626f756e646c65737320666c6f77206f6620626c6f636b636861696e20646174612c207768657265207472656e6473207368696674206c696b6520746964657320616e64206d61726b657420666f726365732064616e636520696e206368616f7469632072687974686d2c206f6e6520656e74697479207374616e64732061732074686520756e7761766572696e6720626561636f6e206f6620636c617269747920e28094205175616e74697675732e202e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Q7_Copy_44c981e302.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<QVUS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QVUS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

