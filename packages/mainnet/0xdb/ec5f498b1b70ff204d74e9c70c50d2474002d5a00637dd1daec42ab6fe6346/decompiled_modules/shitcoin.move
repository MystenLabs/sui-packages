module 0xdbec5f498b1b70ff204d74e9c70c50d2474002d5a00637dd1daec42ab6fe6346::shitcoin {
    struct SHITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHITCOIN>(arg0, 6, b"SHITCOIN", b"SHIT COIN ON SUI", x"5368697420636f696e206f6e205355490a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737008662185.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHITCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHITCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

