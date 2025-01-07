module 0xf23ca73c500641ed55e1eb960fe4c8920d2b0387820b172d1d69a17adac925e7::genz {
    struct GENZ has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GENZ>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GENZ>>(0x2::coin::mint<GENZ>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: GENZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENZ>(arg0, 9, b"GENZ", b"GENZ", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1498068173421170689/IpFF9TQw_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GENZ>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENZ>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

