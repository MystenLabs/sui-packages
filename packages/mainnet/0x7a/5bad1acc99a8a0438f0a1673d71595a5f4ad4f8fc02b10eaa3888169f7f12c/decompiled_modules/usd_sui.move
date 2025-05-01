module 0x7a5bad1acc99a8a0438f0a1673d71595a5f4ad4f8fc02b10eaa3888169f7f12c::usd_sui {
    struct USD_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: USD_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USD_SUI>(arg0, 9, b"usdSUI", b"USD Staked SUI", b"USD Staked Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/87813e17-c72b-42db-b9c1-dd783d92564a/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USD_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USD_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

