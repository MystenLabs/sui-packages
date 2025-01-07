module 0x93e847c07ba9866004d44e34323deece2c454f0b39d154b2d6850ac15aa11591::smp {
    struct SMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMP>(arg0, 6, b"SMP", b"Sui Meme Party", x"57656c636f6d6520746f207468652062657374206d656d652070617274792073696e636520746865206c617374206d656d65636f696e20736561736f6e2c206f6e6c79206f6e20746865200a405375694e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/smp_1c1cdfd795.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

