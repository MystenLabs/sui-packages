module 0x2858ea3035736e1380c3414d6e9de34bc9c9d20ef25176e2f776b1440138dcde::GOAT {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 2, b"Goat", b"Goat", b"A ferocious platypus in Sui Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s1.locimg.com/2024/10/14/839d6592f91bd.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOAT>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOAT>(&mut v2, 31551750000000000, @0x7aed1e213e4ed1b16234506f0e78d94bbb3cf60967540beb841d14d3607b09c4, arg1);
        0x2::coin::mint_and_transfer<GOAT>(&mut v2, 10517250000000000, @0x7aed1e213e4ed1b16234506f0e78d94bbb3cf60967540beb841d14d3607b09c4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

