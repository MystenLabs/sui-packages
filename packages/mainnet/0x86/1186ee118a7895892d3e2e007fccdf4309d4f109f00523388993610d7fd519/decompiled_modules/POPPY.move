module 0x861186ee118a7895892d3e2e007fccdf4309d4f109f00523388993610d7fd519::POPPY {
    struct POPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPPY>(arg0, 9, b"POPPY", b"POPPY 17 USD Maker", b"POPPY 17 USD Maker to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.istockphoto.com/id/104355461/photo/front-view-of-british-shorthair-cat-7-months-old-sitting.jpg?s=612x612&w=0&k=20&c=OXg47eem5DnX2WkX_kcDaZcl5-ARAbaBt6Bu5kLY7LM=")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POPPY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPPY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

