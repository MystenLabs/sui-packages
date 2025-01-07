module 0xba6e8351021de5ad63247201e806df6c020e7e2a2c939b38cf210c5b428d4169::suifwog {
    struct SUIFWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFWOG>(arg0, 6, b"SuiFWOG", b"FWOG", b"In the ashes a community emerged, a new flog, a more based flog, a FWOG. FWOG has no dev. It is the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/22_b2125f2989.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

