module 0xa25062ed368a6e4e446f3badcdfd1deb92537ba9f12faa6bfcce4c4d0330d4f5::eacred {
    struct EACRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: EACRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EACRED>(arg0, 6, b"eACRED", b"Ember ACRED", b"This receipt token represents the shares a user has of the Ember ACRED Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/logos/acred-ember.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EACRED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EACRED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

