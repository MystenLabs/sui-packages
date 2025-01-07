module 0x48f97d2a7bff67752228f8b0c7f5834fc0059c19745d79e6b56da1f56d6bc635::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP>(arg0, 9, b"PUMP", b"BIG PUMP", b"Sui Pump To The Moon Let's Go", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1770990191152603136/YF5EakvX_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUMP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

