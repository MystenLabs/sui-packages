module 0x2fe1868be54545bbb40de0d1b47710168cb296aa18dd8beb11d750fc08b88c2b::metausd {
    struct METAUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: METAUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<METAUSD>(arg0, 6, b"metaUSD", b"Metaversal USD", b"This receipt token represents the shares a user has of the USDai Credit Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/logos/eMETA.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<METAUSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<METAUSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

