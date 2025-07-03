module 0xdd18c6333bf0a244f6ad3c14b92c8b0544fd959bbb1fb4e26731eaa31571aa3e::sfa {
    struct SFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFA>(arg0, 6, b"SFA", b"Sui Fart Aura", b"Sui Fart Aura is  the luminous force that proves true power comes from owning every aspect of yourself, generating compound returns in magnetic presence and unforgettable", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihlog6wangnjqnispepdy4gwoxn4dzizq5gp5v4enz3iawboiyak4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SFA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

