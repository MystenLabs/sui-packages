module 0x4549b2a06d6eead90b7c7b20b58b43b706a602f2fca3417a3f14dae0cca01a0e::lvn {
    struct LVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LVN>(arg0, 6, b"LVN", b"LEVIN", b"Levin: A powerful and fast blockchain token, sparking innovation and scalability for the digital economy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ed1bfaa8_efc1_48de_89b6_f6ae157b4cb1_9e818fc87c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

