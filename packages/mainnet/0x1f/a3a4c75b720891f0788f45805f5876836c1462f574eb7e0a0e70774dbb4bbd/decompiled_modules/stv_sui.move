module 0x1fa3a4c75b720891f0788f45805f5876836c1462f574eb7e0a0e70774dbb4bbd::stv_sui {
    struct STV_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STV_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STV_SUI>(arg0, 9, b"stvSUI", b"Steve Staked SUI", b"Just Stupid Liquid Staking", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/0513e8e5-beb6-42f5-9c8b-de595081a9f6/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STV_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STV_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

