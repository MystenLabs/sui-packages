module 0xa6ed07997b856032c2b5706ff638a0cc3dea55475b1a3b2e68b6dd8a11d931cd::bl {
    struct BL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BL>(arg0, 9, b"BL", b"BullLFG", b"The energy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreienofjadwlu5cuaw7p6gusgltqt6o7x4rdofxha46fbpa6mhx2d5a")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

