module 0x87b39cdbc3ade3a7805a6aded989ed62a8a2b93d3020fc1474f2e58df4fa57e8::wild {
    struct WILD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILD>(arg0, 6, b"WILD", b"WILD n NASTY", b"Raw. Wild. Unleashed.  Exclusive content for my bold followers. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2beb52fb_f0d3_4df8_b405_2c9001b46095_a6d831bf0c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILD>>(v1);
    }

    // decompiled from Move bytecode v6
}

