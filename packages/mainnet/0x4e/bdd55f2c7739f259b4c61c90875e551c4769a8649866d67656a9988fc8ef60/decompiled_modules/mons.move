module 0x4ebdd55f2c7739f259b4c61c90875e551c4769a8649866d67656a9988fc8ef60::mons {
    struct MONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONS>(arg0, 6, b"MONS", b"Monster Sui", b"First Scary Monster Meme in Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732280238218.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

