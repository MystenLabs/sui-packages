module 0xe765804283aa3206a36917b9319508027f3646e6d41154ecef045b5c7d4e5402::KRIYA_SCA_LST_STAGING {
    struct KRIYA_SCA_LST_STAGING has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRIYA_SCA_LST_STAGING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRIYA_SCA_LST_STAGING>(arg0, 6, b"KRIYA_SCA_LST_STAGING", b"KRIYA_SCA_LST_STAGING", b"staging kriya scallop afSUI-SUI leveraged lending token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://assets.coingecko.com/coins/images/29850/standard/pepe-token.jpeg?1696528776"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRIYA_SCA_LST_STAGING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRIYA_SCA_LST_STAGING>>(v1);
    }

    // decompiled from Move bytecode v6
}

