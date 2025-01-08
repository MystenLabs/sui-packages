module 0xffb3118f45d095cd3380e29737a0b53db050319ca3dc2c6ef287e3ab31482a7e::osraaa {
    struct OSRAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSRAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSRAAA>(arg0, 9, b"OSRAAA", b"osraa", b"oss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OSRAAA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSRAAA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSRAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

