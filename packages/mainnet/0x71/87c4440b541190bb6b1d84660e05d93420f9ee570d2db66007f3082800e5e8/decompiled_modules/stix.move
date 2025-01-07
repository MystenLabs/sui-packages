module 0x7187c4440b541190bb6b1d84660e05d93420f9ee570d2db66007f3082800e5e8::stix {
    struct STIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: STIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STIX>(arg0, 9, b"STIX", b"Stix", b"Create Culture, Create Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1808276284323385347/0HoSLw7o_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STIX>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STIX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

