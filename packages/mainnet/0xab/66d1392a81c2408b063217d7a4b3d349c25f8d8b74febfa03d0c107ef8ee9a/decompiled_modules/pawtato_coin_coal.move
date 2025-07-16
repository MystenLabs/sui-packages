module 0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal {
    struct PAWTATO_COIN_COAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_COAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_COAL>(arg0, 9, b"COAL", b"Pawtato Coal", b"Valuable fuel source extracted from Pawtato Lands.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/coal.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_COAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_COAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_coal(arg0: 0x2::coin::Coin<PAWTATO_COIN_COAL>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_COAL>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

