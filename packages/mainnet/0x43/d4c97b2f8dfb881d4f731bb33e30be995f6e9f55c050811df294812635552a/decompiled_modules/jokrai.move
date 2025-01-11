module 0x43d4c97b2f8dfb881d4f731bb33e30be995f6e9f55c050811df294812635552a::jokrai {
    struct JOKRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKRAI>(arg0, 6, b"Jokrai", b"Agent Joker ai", x"4d656574204a6f6b65722041492020596f757220616c6c2d696e2d6f6e652054656c656772616d20626f7420666f72206a6f6b65732c20726964646c65732c2070757a7a6c65732c20616e6420746872696c6c696e672067616d657321200a4e6f7720706f7765726564206279204a6f6b657220546f6b656e20284a4f4b52292c457870657269656e636520746865207065726665637420626c656e64206f662066756e2c2041492c20616e642063727970746f20696e6e6f766174696f6e6a6f696e20746865207265766f6c7574696f6e20746f646179", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014205_612c74dfef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKRAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOKRAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

