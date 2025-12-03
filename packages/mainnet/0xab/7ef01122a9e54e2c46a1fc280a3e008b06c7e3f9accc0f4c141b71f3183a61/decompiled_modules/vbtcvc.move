module 0xab7ef01122a9e54e2c46a1fc280a3e008b06c7e3f9accc0f4c141b71f3183a61::vbtcvc {
    struct VBTCVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: VBTCVC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VBTCVC>(arg0, 8, b"vBTCvc", b"Vishwa Vault BTCvc", b"This receipt token represents the shares a user has of the Ember BTCvc Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/logos/eBTCvc.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VBTCVC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VBTCVC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

