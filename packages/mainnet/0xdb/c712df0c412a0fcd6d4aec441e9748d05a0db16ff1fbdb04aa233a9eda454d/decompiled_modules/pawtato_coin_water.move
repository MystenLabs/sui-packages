module 0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water {
    struct PAWTATO_COIN_WATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_WATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_WATER>(arg0, 9, b"WATER", b"Pawtato Water", b"Essential life resource gathered from Pawtato Lands.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/water.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_WATER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_WATER>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_water(arg0: 0x2::coin::Coin<PAWTATO_COIN_WATER>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_WATER>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

