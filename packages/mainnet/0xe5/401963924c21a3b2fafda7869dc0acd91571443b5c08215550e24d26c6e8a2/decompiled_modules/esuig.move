module 0xe5401963924c21a3b2fafda7869dc0acd91571443b5c08215550e24d26c6e8a2::esuig {
    struct ESUIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESUIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESUIG>(arg0, 9, b"eSUIG", b"Ember SUIG", b"This receipt token represents the shares a user has of the Ember SUIG Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.bluefin.io/images/ember-suig.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ESUIG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESUIG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

