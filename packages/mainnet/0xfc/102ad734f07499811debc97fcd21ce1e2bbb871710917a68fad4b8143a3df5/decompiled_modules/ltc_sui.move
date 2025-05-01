module 0xfc102ad734f07499811debc97fcd21ce1e2bbb871710917a68fad4b8143a3df5::ltc_sui {
    struct LTC_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LTC_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LTC_SUI>(arg0, 9, b"ltcSUI", b"Litecoin Staked SUI", b"Litecoin Staked Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/6459c166-e683-48b5-9986-e050ed9dee9e/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LTC_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LTC_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

