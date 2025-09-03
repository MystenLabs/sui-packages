module 0x4dc301602277552a6c2c3309b02a70f7aae27eeeb300863de9466b4c1be7d568::egsui {
    struct EGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGSUI>(arg0, 9, b"egSUI", b"Ember Gamma SUI", b"This receipt token represents the shares a user has of the Gamma SUI Vault on Ember", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/logos/egSUI.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

