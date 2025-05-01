module 0xd3908d23a0501bd98c65e1fa4f04ad81cab4b088854c6319861a5645d3b2bfd0::dai_sui {
    struct DAI_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAI_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAI_SUI>(arg0, 9, b"daiSUI", b"Dai Staked SUI", b"Dai Staked Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/2149bc53-fc6d-4d05-a807-6723fe321cca/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAI_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAI_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

