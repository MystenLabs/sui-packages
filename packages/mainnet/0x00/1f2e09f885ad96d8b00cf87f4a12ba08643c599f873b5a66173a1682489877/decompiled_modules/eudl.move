module 0x1f2e09f885ad96d8b00cf87f4a12ba08643c599f873b5a66173a1682489877::eudl {
    struct EUDL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EUDL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EUDL>(arg0, 6, b"eUDL", b"Ember UDL", b"This receipt token represents the shares a user has of the Ember UDL Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/logos/undefinied-labs-ember.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EUDL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EUDL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

