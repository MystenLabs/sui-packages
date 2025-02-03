module 0xcb9114fd543277c9b8c01acacd891248fd9fe4b4912df0d225c739825426b84a::thesuinami {
    struct THESUINAMI has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<THESUINAMI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<THESUINAMI>>(0x2::coin::mint<THESUINAMI>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: THESUINAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THESUINAMI>(arg0, 9, b"SUNAMI", b"TheSuinami", b"Real authentic TheSuinami wave on the blockchain inspired by Phantom and hack a ton.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1551047374872555520/Z0mT7_qs_400x400.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<THESUINAMI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THESUINAMI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THESUINAMI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

