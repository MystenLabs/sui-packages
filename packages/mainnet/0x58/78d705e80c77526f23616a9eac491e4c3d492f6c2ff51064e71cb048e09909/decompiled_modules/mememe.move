module 0x5878d705e80c77526f23616a9eac491e4c3d492f6c2ff51064e71cb048e09909::mememe {
    struct MEMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEME>(arg0, 6, b"MEMEME", b"MEMEME SUI", b"Buy now or never", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1846625522668982272/5t4ZOgU__400x400.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEME>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEMEME>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEME>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

