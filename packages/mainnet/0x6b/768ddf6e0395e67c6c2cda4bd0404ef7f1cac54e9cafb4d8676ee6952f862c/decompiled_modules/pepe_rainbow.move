module 0x6b768ddf6e0395e67c6c2cda4bd0404ef7f1cac54e9cafb4d8676ee6952f862c::pepe_rainbow {
    struct PEPE_RAINBOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE_RAINBOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE_RAINBOW>(arg0, 9, b"Pepe Rainbow", b"Pepe Rainbow Coin", b"Pepe Rainbow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775534147922-5e2c8ace56e47383bdcef2dffb367ca3.gif"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPE_RAINBOW>>(0x2::coin::mint<PEPE_RAINBOW>(&mut v2, 20000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPE_RAINBOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE_RAINBOW>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

