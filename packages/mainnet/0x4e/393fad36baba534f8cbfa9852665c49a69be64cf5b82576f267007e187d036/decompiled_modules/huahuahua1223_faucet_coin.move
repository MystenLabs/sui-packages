module 0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_faucet_coin {
    struct HUAHUAHUA1223_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUAHUAHUA1223_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUAHUAHUA1223_FAUCET_COIN>(arg0, 8, b"HUAHUAHUA1223_FAUCET_COIN", b"HUAHUAHUA1223_FAUCET_COIN", b"this is my faucet coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/138219491")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUAHUAHUA1223_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HUAHUAHUA1223_FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

