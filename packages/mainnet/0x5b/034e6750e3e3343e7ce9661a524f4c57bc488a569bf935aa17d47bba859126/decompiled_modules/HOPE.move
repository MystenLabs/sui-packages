module 0x5b034e6750e3e3343e7ce9661a524f4c57bc488a569bf935aa17d47bba859126::HOPE {
    struct HOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPE>(arg0, 9, b"HOPE", b"HOPE 3 USD Maker", b"HOPE 3 USD Maker to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.istockphoto.com/id/104355461/photo/front-view-of-british-shorthair-cat-7-months-old-sitting.jpg?s=612x612&w=0&k=20&c=OXg47eem5DnX2WkX_kcDaZcl5-ARAbaBt6Bu5kLY7LM=")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOPE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

