module 0x83f1bb8c91ecd1fd313344058b0eed94d63c54e41d8d1ae5bff1353443517d65::yap_sui {
    struct YAP_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAP_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAP_SUI>(arg0, 9, b"yapSUI", b"Yap Staked SUI", b"Yap Staked SUI is a liquid staking protocol on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/springsui/ecosystem/yapSUI.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAP_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAP_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

