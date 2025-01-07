module 0x6c1170bb7f6ebaa3a3804fce26a83f4b7fc22307974569b59e4c7b167af7009::spopcat {
    struct SPOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOPCAT>(arg0, 9, b"Sui POPCAT", b"SPOPCAT", b"ONLY UP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/184kK4k/sui-popcat.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPOPCAT>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPOPCAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOPCAT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

