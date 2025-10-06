module 0x89b0d4407f17cc1b1294464f28e176e29816a40612f7a553313ea0a797a5f803::ethird {
    struct ETHIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETHIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETHIRD>(arg0, 6, b"eTHIRD", b"Ember Third Eye", b"This receipt token represents the shares a user has of the Ember Third Eye Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/logos/egUSDC.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETHIRD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETHIRD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

