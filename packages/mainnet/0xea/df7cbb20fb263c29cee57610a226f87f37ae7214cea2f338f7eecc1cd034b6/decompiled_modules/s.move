module 0xeadf7cbb20fb263c29cee57610a226f87f37ae7214cea2f338f7eecc1cd034b6::s {
    struct S has drop {
        dummy_field: bool,
    }

    fun init(arg0: S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S>(arg0, 6, b"S", b"S-Coin", x"546f6b656e697a656420417274202d20546865205320796f75207573656420746f206472617720696e207363686f6f6c2074686174206272696e6773206261636b20736f206d616e79206d656d6f726965730a0a5768656e20776520776572656e277420706179696e6720617474656e74696f6e20696e20636c6173732062656361757365207765207765726520746f6f2062757379206265696e67206175746973746963", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unnamed_2_bf1dca5833.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S>>(v1);
    }

    // decompiled from Move bytecode v6
}

