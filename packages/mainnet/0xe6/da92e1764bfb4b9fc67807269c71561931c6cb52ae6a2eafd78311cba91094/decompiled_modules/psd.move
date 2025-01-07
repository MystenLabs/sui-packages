module 0xe6da92e1764bfb4b9fc67807269c71561931c6cb52ae6a2eafd78311cba91094::psd {
    struct PSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSD>(arg0, 6, b"PSD", b"PoSuidon", x"546865206f6666696369616c20546f6b656e206f66204c6f726420506f537569646f6e2e0a4d6179207468652077617465727320666c6f772e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732076528988.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

