module 0x497121a5ff22c04e81e50fd607a3aef87ae0ba7b185a42cc517eb4d32e6f90a1::mnst_sui {
    struct MNST_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNST_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNST_SUI>(arg0, 9, b"mnstSUI", b"mnst Staked SUI", b"nst", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/e25caaf6-4ae2-4270-bd32-d18e4afcf51e/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNST_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MNST_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

