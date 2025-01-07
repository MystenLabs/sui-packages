module 0xfb69c6e0abefe0aeb019584763671e3a3293f4b899022e24c03570960950aa89::monkeys {
    struct MONKEYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKEYS>(arg0, 6, b"MONKEYS", b"SUI MONKEYS", b"SUI MONKEY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_86a357afcc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKEYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

