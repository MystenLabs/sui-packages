module 0x874b73e5ed5e8ab3326f7965ba1b4dc61884252f3c57a7da94cef6ad10b0070c::COP {
    struct COP has drop {
        dummy_field: bool,
    }

    fun init(arg0: COP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COP>(arg0, 9, b"COP", b"COP USD Maker", b"COP USD Maker to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.istockphoto.com/id/104355461/photo/front-view-of-british-shorthair-cat-7-months-old-sitting.jpg?s=612x612&w=0&k=20&c=OXg47eem5DnX2WkX_kcDaZcl5-ARAbaBt6Bu5kLY7LM=")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COP>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

