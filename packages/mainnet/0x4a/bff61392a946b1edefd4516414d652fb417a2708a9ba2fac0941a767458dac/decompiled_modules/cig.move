module 0x4abff61392a946b1edefd4516414d652fb417a2708a9ba2fac0941a767458dac::cig {
    struct CIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIG>(arg0, 6, b"Cig", b"CIG", b"Cig on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cigg_54c067c1c3.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

