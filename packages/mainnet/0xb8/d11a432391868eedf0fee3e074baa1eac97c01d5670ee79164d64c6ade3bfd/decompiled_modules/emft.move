module 0xb8d11a432391868eedf0fee3e074baa1eac97c01d5670ee79164d64c6ade3bfd::emft {
    struct EMFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMFT>(arg0, 6, b"eMFT", b"Ember Mid Frequency", b"This receipt token represents the shares a user has of the Ember Mid Frequency Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/logos/eELP.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMFT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMFT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

