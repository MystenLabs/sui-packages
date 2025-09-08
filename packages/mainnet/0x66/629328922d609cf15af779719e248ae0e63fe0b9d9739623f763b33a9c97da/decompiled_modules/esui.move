module 0x66629328922d609cf15af779719e248ae0e63fe0b9d9739623f763b33a9c97da::esui {
    struct ESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESUI>(arg0, 9, b"eSUI", b"Ember SUI", b"This receipt token represents the shares a user has of the Ember SUI Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/logos/egSUI.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ESUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

