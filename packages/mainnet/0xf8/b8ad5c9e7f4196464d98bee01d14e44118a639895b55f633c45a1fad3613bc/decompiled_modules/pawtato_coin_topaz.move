module 0xf8b8ad5c9e7f4196464d98bee01d14e44118a639895b55f633c45a1fad3613bc::pawtato_coin_topaz {
    struct PAWTATO_COIN_TOPAZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_TOPAZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_TOPAZ>(arg0, 9, b"TOPAZ", b"Pawtato Topaz", b"A properly cut and polished Topaz, offering clear color and radiance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/topaz.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_TOPAZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_TOPAZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_topaz(arg0: 0x2::coin::Coin<PAWTATO_COIN_TOPAZ>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_TOPAZ>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

