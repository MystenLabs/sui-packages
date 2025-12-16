module 0x991eee2f1e181f1697325f027bcfc8dbfcf1fdb14b633d58427c96d503efa843::pawtato_coin_perfect_amethyst {
    struct PAWTATO_COIN_PERFECT_AMETHYST has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_PERFECT_AMETHYST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_PERFECT_AMETHYST>(arg0, 9, b"PERFECT_AMETHYST", b"Pawtato Perfect Amethyst", b"An Amethyst with flawless clarity, ideal symmetry, and maximum brilliance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/amethyst-perfect.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_PERFECT_AMETHYST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_PERFECT_AMETHYST>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_perfect_amethyst(arg0: 0x2::coin::Coin<PAWTATO_COIN_PERFECT_AMETHYST>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_PERFECT_AMETHYST>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

