module 0x3a93d454cea46cf28c0f6a0a29095a441fe5ec27879d64a6b2181921bf4fcc08::pawtato_coin_chipped_sapphire {
    struct PAWTATO_COIN_CHIPPED_SAPPHIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_CHIPPED_SAPPHIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_CHIPPED_SAPPHIRE>(arg0, 9, b"CHIPPED_SAPPHIRE", b"Pawtato Chipped Sapphire", b"A small and slightly damaged Sapphire with visible imperfections that reduce brilliance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/sapphire-chipped.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_CHIPPED_SAPPHIRE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_CHIPPED_SAPPHIRE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_chipped_sapphire(arg0: 0x2::coin::Coin<PAWTATO_COIN_CHIPPED_SAPPHIRE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_CHIPPED_SAPPHIRE>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

