module 0x34add66f0106133ef47ded7e591d8fc4a4e102fdcee20c979c73f5ab1d61a281::DOLAN {
    struct DOLAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLAN>(arg0, 2, b"Dolan Duck", b"Dolan", b"A ferocious platypus in Sui Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FU9w_In7_NX_400x400_934b0d5d79.jpg&w=640&q=75")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOLAN>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOLAN>(&mut v2, 31551750000000000, @0x7aed1e213e4ed1b16234506f0e78d94bbb3cf60967540beb841d14d3607b09c4, arg1);
        0x2::coin::mint_and_transfer<DOLAN>(&mut v2, 10517250000000000, @0x7aed1e213e4ed1b16234506f0e78d94bbb3cf60967540beb841d14d3607b09c4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLAN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

