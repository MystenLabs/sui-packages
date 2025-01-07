module 0xc575cd8d60f95804b11a298bd2ac1fd9d84c67d4319575d892a58c3450eebf80::mememe {
    struct MEMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEME>(arg0, 6, b"MEMEME", b"MEMEME SUI", b"Buy now or never", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1846625522668982272/5t4ZOgU__400x400.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEME>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEMEME>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEME>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

