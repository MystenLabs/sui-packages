module 0x5158d67169434694330813ab96862a05ec6de939984ac7a02ccb62a604bd4565::pawtato_coin_stone_q_rune {
    struct PAWTATO_COIN_STONE_Q_RUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_STONE_Q_RUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_STONE_Q_RUNE>(arg0, 9, b"STONE_Q_RUNE", b"Pawtato Stone Q Rune", b"Stone Rune with a runic Q.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_consumables/stone-q-rune.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_STONE_Q_RUNE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_STONE_Q_RUNE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_stone_q_rune(arg0: 0x2::coin::Coin<PAWTATO_COIN_STONE_Q_RUNE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_STONE_Q_RUNE>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

