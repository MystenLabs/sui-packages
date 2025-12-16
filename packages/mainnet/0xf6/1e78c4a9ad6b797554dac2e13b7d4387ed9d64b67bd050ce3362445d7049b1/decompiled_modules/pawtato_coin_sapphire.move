module 0xf61e78c4a9ad6b797554dac2e13b7d4387ed9d64b67bd050ce3362445d7049b1::pawtato_coin_sapphire {
    struct PAWTATO_COIN_SAPPHIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_SAPPHIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_SAPPHIRE>(arg0, 9, b"SAPPHIRE", b"Pawtato Sapphire", b"A properly cut and polished Sapphire, offering clear color and radiance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/sapphire.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_SAPPHIRE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_SAPPHIRE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_sapphire(arg0: 0x2::coin::Coin<PAWTATO_COIN_SAPPHIRE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_SAPPHIRE>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

