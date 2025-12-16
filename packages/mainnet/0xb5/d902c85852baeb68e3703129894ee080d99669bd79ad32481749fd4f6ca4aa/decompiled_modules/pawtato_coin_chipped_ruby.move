module 0xb5d902c85852baeb68e3703129894ee080d99669bd79ad32481749fd4f6ca4aa::pawtato_coin_chipped_ruby {
    struct PAWTATO_COIN_CHIPPED_RUBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_CHIPPED_RUBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_CHIPPED_RUBY>(arg0, 9, b"CHIPPED_RUBY", b"Pawtato Chipped Ruby", b"A small and slightly damaged Ruby with visible imperfections that reduce brilliance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/ruby-chipped.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_CHIPPED_RUBY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_CHIPPED_RUBY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_chipped_ruby(arg0: 0x2::coin::Coin<PAWTATO_COIN_CHIPPED_RUBY>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_CHIPPED_RUBY>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

