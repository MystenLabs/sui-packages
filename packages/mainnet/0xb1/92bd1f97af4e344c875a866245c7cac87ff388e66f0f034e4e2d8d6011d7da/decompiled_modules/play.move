module 0xb192bd1f97af4e344c875a866245c7cac87ff388e66f0f034e4e2d8d6011d7da::play {
    struct PLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLAY>(arg0, 6, b"PLAY", b"Play Sui", b"First game meme token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1763720303011.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLAY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLAY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

