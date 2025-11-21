module 0x6e6b58a710a5d59cfc44ba3af8004dd832af980a62c4519818ff463caf35a493::epoly {
    struct EPOLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EPOLY>(arg0, 6, b"ePOLY", b"Ember Polymarket", b"This receipt token represents the shares a user has of the Ember Polymarket Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/logos/polymarket-ember.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EPOLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPOLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

