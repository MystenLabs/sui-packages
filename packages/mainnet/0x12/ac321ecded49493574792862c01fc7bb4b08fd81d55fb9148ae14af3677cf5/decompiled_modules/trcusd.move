module 0x12ac321ecded49493574792862c01fc7bb4b08fd81d55fb9148ae14af3677cf5::trcusd {
    struct TRCUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRCUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRCUSD>(arg0, 6, b"trcUSD", b"Topnod rcUSD", b"This receipt token represents the shares a user has of the R25 Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/logos/rcusd-logo-ember.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRCUSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRCUSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

