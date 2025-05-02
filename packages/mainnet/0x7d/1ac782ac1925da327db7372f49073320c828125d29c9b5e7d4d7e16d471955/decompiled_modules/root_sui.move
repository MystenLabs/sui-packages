module 0x7d1ac782ac1925da327db7372f49073320c828125d29c9b5e7d4d7e16d471955::root_sui {
    struct ROOT_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOT_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROOT_SUI>(arg0, 9, b"rootSUI", b"root Staked SUI", b"rootardedSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/6b98efd7-f2d2-4145-a4e9-1818bb9b3227/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROOT_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROOT_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

