module 0xf5f4089bf801beedc3c9f044c99bde25b29a08ded99265e9aaec714750629726::lan1 {
    struct LAN1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAN1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAN1>(arg0, 6, b"LAN1", b"LAN001", b"001", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQe-ZoID5oe_-y-2jpqpHOjTg8-3uNP3dZ6Vg&s"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LAN1>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAN1>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LAN1>>(v2);
    }

    // decompiled from Move bytecode v6
}

