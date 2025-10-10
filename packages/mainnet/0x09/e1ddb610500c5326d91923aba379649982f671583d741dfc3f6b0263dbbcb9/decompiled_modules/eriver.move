module 0x9e1ddb610500c5326d91923aba379649982f671583d741dfc3f6b0263dbbcb9::eriver {
    struct ERIVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERIVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERIVER>(arg0, 6, b"eRIVER", b"Ember Rivershore", b"This receipt token represents the shares a user has of the Ember Concentrated Liquidity Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/logos/eRIVER.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERIVER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERIVER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

