module 0x70d3b953f9dd27a2290614a2f12d72434699b20d33835a74151ca7c6764d4baa::qduck {
    struct QDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: QDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QDUCK>(arg0, 6, b"QDUCK", b"QuantumDuck", b"QuantumDuck combines futuristic technology with meme culture, making your investments as agile as a duck, ready to jump on the next surge. Quack! Quack! Quack!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748793680778.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QDUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QDUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

