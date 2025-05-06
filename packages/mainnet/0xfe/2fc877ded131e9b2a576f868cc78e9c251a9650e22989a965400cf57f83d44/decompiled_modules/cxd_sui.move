module 0xfe2fc877ded131e9b2a576f868cc78e9c251a9650e22989a965400cf57f83d44::cxd_sui {
    struct CXD_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CXD_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CXD_SUI>(arg0, 9, b"cxdSUI", b"INDust Staked SUI", b"INDust is a liquid staking ai tool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/17a59912-c21d-4aca-a3ca-65d653ccbfc9/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CXD_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CXD_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

