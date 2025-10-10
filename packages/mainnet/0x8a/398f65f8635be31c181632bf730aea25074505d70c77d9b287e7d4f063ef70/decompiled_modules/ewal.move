module 0x8a398f65f8635be31c181632bf730aea25074505d70c77d9b287e7d4f063ef70::ewal {
    struct EWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EWAL>(arg0, 9, b"eWAL", b"Ember WAL", b"This receipt token represents the shares a user has of the Ember WAL Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/logos/eWAL.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EWAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EWAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

