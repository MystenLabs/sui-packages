module 0x4f8e0f2a09118179a91d86ec0553f85c992bd7d59a659320d4a58f504b8baf8::mvn {
    struct MVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MVN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MVN>(arg0, 6, b"MVN", b"Market Maven by SuiAI", b"Market Maven AI and similar tools are invaluable for businesses looking to stay competitive in a rapidly changing market landscape. By leveraging AI and machine learning, these tools provide deep insights that can drive strategic decisions and foster growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/maven_7f98e6d2d9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MVN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MVN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

