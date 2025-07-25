module 0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank {
    struct PAWTATO_COIN_WOODEN_PLANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_WOODEN_PLANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_WOODEN_PLANK>(arg0, 9, b"WOODEN_PLANK", b"Pawtato Wooden Plank", b"Processed wooden boards used for building and crafting.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/wooden-plank.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_WOODEN_PLANK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_WOODEN_PLANK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_wooden_plank(arg0: 0x2::coin::Coin<PAWTATO_COIN_WOODEN_PLANK>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_WOODEN_PLANK>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

