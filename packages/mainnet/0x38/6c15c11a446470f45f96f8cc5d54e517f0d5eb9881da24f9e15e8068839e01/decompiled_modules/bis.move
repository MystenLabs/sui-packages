module 0x386c15c11a446470f45f96f8cc5d54e517f0d5eb9881da24f9e15e8068839e01::bis {
    struct BIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIS>(arg0, 6, b"Bis", b"Biscuit", b"Agent Biscuit, solving the mysteries of the lost cookies on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3586_dd3bc2ce75.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

