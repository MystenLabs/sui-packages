module 0xc46b11d90c005a13a0299091499ca53e714b541c04ae164073e884df757e00c2::qnn {
    struct QNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: QNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QNN>(arg0, 6, b"QNN", b"QNN ELON NEWS", b"ELON MUSK NEWS with meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731894360676.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QNN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QNN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

