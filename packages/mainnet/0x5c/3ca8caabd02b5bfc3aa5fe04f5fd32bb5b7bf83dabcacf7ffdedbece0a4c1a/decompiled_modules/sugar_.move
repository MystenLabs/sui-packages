module 0x5c3ca8caabd02b5bfc3aa5fe04f5fd32bb5b7bf83dabcacf7ffdedbece0a4c1a::sugar_ {
    struct SUGAR_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGAR_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGAR_>(arg0, 9, b"SUGAR", b"SUGAR", b"sweeet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUGAR_>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGAR_>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUGAR_>>(v1);
    }

    // decompiled from Move bytecode v6
}

