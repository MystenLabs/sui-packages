module 0x3983a6a8b4407c8c96f6beb1ecfc458f7d6fd85ccb2b290e02c09374ee468af6::xrp_sui {
    struct XRP_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XRP_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XRP_SUI>(arg0, 9, b"xrpSUI", b"Ripple Staked SUI", b"Ripple Staked Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/44940ab5-1abe-4dbf-96de-73e284abea0b/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XRP_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XRP_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

