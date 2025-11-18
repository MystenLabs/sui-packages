module 0x267a6e56d07057ba827c38904eb30614d3f01fd052129a709e74d0bb4ed9be3c::ercusd {
    struct ERCUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERCUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERCUSD>(arg0, 6, b"ercUSD", b"Ember rcUSD", b"This receipt token represents the shares a user has of the Ember rcUSD Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/logos/rcusd-logo-ember.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERCUSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERCUSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

