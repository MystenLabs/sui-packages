module 0x4c7299009a3d66865d88d4dc9a0e20f671c8bfc0b4c3b028e65cbfb151a663df::blackneon {
    struct BLACKNEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKNEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKNEON>(arg0, 2, b"BLACKNEON", b"The Black Neon", b"A crypto currency that can be earned for free by using www.theblackneon.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLACKNEON>(&mut v2, 5000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKNEON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACKNEON>>(v1);
    }

    // decompiled from Move bytecode v6
}

