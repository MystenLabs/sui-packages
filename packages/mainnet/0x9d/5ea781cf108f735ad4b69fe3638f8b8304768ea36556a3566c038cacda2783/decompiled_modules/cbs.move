module 0x9d5ea781cf108f735ad4b69fe3638f8b8304768ea36556a3566c038cacda2783::cbs {
    struct CBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBS>(arg0, 9, b"CBS", b"COBBYSNOW", b"A meme that's going to take the world by storm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c08cb415-aecd-481d-af28-5268e387ce6c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

