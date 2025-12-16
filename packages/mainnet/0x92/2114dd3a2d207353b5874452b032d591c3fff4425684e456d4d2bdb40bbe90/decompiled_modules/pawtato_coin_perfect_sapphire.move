module 0x922114dd3a2d207353b5874452b032d591c3fff4425684e456d4d2bdb40bbe90::pawtato_coin_perfect_sapphire {
    struct PAWTATO_COIN_PERFECT_SAPPHIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_PERFECT_SAPPHIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_PERFECT_SAPPHIRE>(arg0, 9, b"PERFECT_SAPPHIRE", b"Pawtato Perfect Sapphire", b"A Sapphire with flawless clarity, ideal symmetry, and maximum brilliance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/sapphire-perfect.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_PERFECT_SAPPHIRE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_PERFECT_SAPPHIRE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_perfect_sapphire(arg0: 0x2::coin::Coin<PAWTATO_COIN_PERFECT_SAPPHIRE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_PERFECT_SAPPHIRE>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

