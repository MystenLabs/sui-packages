module 0x573f87e6cdc61f0b51b946bb57ba9df65b489f19ee01adab0f07a562d2059a7::pawtato_coin_chipped_topaz {
    struct PAWTATO_COIN_CHIPPED_TOPAZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_CHIPPED_TOPAZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_CHIPPED_TOPAZ>(arg0, 9, b"CHIPPED_TOPAZ", b"Pawtato Chipped Topaz", b"A small and slightly damaged Topaz with visible imperfections that reduce brilliance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/topaz-chipped.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_CHIPPED_TOPAZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_CHIPPED_TOPAZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_chipped_topaz(arg0: 0x2::coin::Coin<PAWTATO_COIN_CHIPPED_TOPAZ>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_CHIPPED_TOPAZ>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

