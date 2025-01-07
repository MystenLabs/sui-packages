module 0x10b8190d78c0e29e64059f10526c885eb842bd5b27ac7fddf2ea510872e9e46::sduck {
    struct SDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDUCK>(arg0, 6, b"SDUCK", b"SUIDUCK", b"CHECK OUT SUI DUCK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x22e389e160025e0b119f0dfb15d5ebfe95e3b4d17290a0a4427e5afcd2c8b80f_suidu_suidu_8d386ab390.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

