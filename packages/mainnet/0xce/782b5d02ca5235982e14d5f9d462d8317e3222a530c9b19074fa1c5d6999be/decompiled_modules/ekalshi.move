module 0xce782b5d02ca5235982e14d5f9d462d8317e3222a530c9b19074fa1c5d6999be::ekalshi {
    struct EKALSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EKALSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EKALSHI>(arg0, 6, b"eKALSHI", b"Ember Kalshi", b"This receipt token represents the shares a user has of the Ember Kalshi Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/logos/eKALSHI.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EKALSHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EKALSHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

