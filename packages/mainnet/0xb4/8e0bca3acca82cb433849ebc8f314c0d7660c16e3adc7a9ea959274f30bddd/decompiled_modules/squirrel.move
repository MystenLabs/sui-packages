module 0xb48e0bca3acca82cb433849ebc8f314c0d7660c16e3adc7a9ea959274f30bddd::squirrel {
    struct SQUIRREL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRREL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRREL>(arg0, 6, b"SQUIRREL", b"TURBOS SQUIRREL", b"Introducing SuiSquirrel Coin: The Freshest MemeCoin in the Game!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730989092311.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUIRREL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRREL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

