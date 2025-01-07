module 0x7f1e1ad1fde56dadf3caa2516f57dfd6456e3e3d62bee6a825ad59f25d8ce19d::dukienz {
    struct DUKIENZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUKIENZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUKIENZ>(arg0, 6, b"DUKIENZ", b"Sui Dukienz", b"Dukienz on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dukienz_logo_4566b93c04.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUKIENZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUKIENZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

