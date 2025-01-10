module 0xfd81bf0b7cf19cddf862d49c16b04c8555b98618a38d786d5b66cce0400816c9::swarm {
    struct SWARM has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SWARM>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SWARM>>(0x2::coin::mint<SWARM>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: SWARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWARM>(arg0, 9, b"SWARM", b"SWARM", b"Have you seen a SWARM of fishes, multiple Ai agents corresponding among each other making a SWARM of Ai combine that with one of the biggest chains, data is now visible no more outages in scans.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/817101887346380800/-JvnXm33_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SWARM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWARM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWARM>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

