module 0x85b58085d458c0855388b68ead197b19a4d3734277b104344f80b735f5632361::flame {
    struct FLAME has drop {
        dummy_field: bool,
    }

    fun get_coin_unit(arg0: u8) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: FLAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 6;
        let (v1, v2) = 0x2::coin::create_currency<FLAME>(arg0, v0, b"TestFLAME", b"Flame Token", b"Flame Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://flameswap.io/assets/coins/FLAME.png")), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<FLAME>>(0x2::coin::mint<FLAME>(&mut v3, mul_u64(100000000, get_coin_unit(v0)), arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLAME>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAME>>(v3, 0x2::tx_context::sender(arg1));
    }

    fun mul_u64(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        assert!(v0 <= 18446744073709551, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

