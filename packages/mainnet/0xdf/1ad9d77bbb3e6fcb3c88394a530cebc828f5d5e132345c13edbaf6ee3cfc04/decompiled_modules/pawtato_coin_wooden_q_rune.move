module 0xdf1ad9d77bbb3e6fcb3c88394a530cebc828f5d5e132345c13edbaf6ee3cfc04::pawtato_coin_wooden_q_rune {
    struct PAWTATO_COIN_WOODEN_Q_RUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_WOODEN_Q_RUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_WOODEN_Q_RUNE>(arg0, 9, b"WOODEN_Q_RUNE", b"Pawtato Wooden Q Rune", b"Wooden Rune with a runic Q.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_consumables/wooden-q-rune.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_WOODEN_Q_RUNE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_WOODEN_Q_RUNE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_wooden_q_rune(arg0: 0x2::coin::Coin<PAWTATO_COIN_WOODEN_Q_RUNE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_WOODEN_Q_RUNE>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

