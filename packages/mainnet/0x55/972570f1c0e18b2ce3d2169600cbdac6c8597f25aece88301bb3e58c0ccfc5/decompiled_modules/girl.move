module 0x55972570f1c0e18b2ce3d2169600cbdac6c8597f25aece88301bb3e58c0ccfc5::girl {
    struct GIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIRL>(arg0, 9, b"GIRL", b"GIRL", b"Happy New Year Fam!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1775654830666641408/PGoljjKL_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GIRL>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIRL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIRL>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

