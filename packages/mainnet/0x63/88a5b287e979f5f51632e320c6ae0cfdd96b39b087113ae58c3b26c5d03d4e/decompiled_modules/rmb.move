module 0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb {
    struct RMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: RMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RMB>(arg0, 8, b"RMB", b"RMB", b"Guoying2026RMB", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RMB>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<RMB>>(v0);
    }

    public entry fun my_burn(arg0: &mut 0x2::coin::TreasuryCap<RMB>, arg1: 0x2::coin::Coin<RMB>) {
        0x2::coin::burn<RMB>(arg0, arg1);
    }

    public entry fun my_mint(arg0: &mut 0x2::coin::TreasuryCap<RMB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RMB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

