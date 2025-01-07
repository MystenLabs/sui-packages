module 0xe9b59244e1759eff96d278e7c2f5292c605a7c1c3c4f02d209f7c094de80a3d9::COP {
    struct COP has drop {
        dummy_field: bool,
    }

    fun init(arg0: COP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COP>(arg0, 9, b"COP", b"COP 1 USD Maker", b"COP 1 USD Maker to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.istockphoto.com/id/104355461/photo/front-view-of-british-shorthair-cat-7-months-old-sitting.jpg?s=612x612&w=0&k=20&c=OXg47eem5DnX2WkX_kcDaZcl5-ARAbaBt6Bu5kLY7LM=")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COP>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

