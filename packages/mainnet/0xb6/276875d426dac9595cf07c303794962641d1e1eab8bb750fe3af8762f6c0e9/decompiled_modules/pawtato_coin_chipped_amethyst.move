module 0xb6276875d426dac9595cf07c303794962641d1e1eab8bb750fe3af8762f6c0e9::pawtato_coin_chipped_amethyst {
    struct PAWTATO_COIN_CHIPPED_AMETHYST has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_CHIPPED_AMETHYST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_CHIPPED_AMETHYST>(arg0, 9, b"CHIPPED_AMETHYST", b"Pawtato Chipped Amethyst", b"A small and slightly damaged Amethyst with visible imperfections that reduce brilliance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/amethyst-chipped.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_CHIPPED_AMETHYST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_CHIPPED_AMETHYST>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_chipped_amethyst(arg0: 0x2::coin::Coin<PAWTATO_COIN_CHIPPED_AMETHYST>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_CHIPPED_AMETHYST>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

