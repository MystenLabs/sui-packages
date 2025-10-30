module 0x2670e7102f3903f72be14f27676283f62a181742483a661caba7f9a1821a2c22::ebtcvc {
    struct EBTCVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: EBTCVC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EBTCVC>(arg0, 8, b"eBTCvc", b"Ember BTCvc", b"This receipt token represents the shares a user has of the Ember Vishwa Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/logos/eBTCvc.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EBTCVC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EBTCVC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

