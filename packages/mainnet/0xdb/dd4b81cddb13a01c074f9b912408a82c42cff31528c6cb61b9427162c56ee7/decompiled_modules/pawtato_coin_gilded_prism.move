module 0xdbdd4b81cddb13a01c074f9b912408a82c42cff31528c6cb61b9427162c56ee7::pawtato_coin_gilded_prism {
    struct PAWTATO_COIN_GILDED_PRISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_GILDED_PRISM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_GILDED_PRISM>(arg0, 9, b"GILDED_PRISM", b"Pawtato Gilded Prism", b"A masterfully crafted ornament said to bring luck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_consumables/gilded-prism.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_GILDED_PRISM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_GILDED_PRISM>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_gilded_prism(arg0: 0x2::coin::Coin<PAWTATO_COIN_GILDED_PRISM>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_GILDED_PRISM>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

