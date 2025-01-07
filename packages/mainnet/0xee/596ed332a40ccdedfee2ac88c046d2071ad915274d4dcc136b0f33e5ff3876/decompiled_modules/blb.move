module 0xee596ed332a40ccdedfee2ac88c046d2071ad915274d4dcc136b0f33e5ff3876::blb {
    struct BLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLB>(arg0, 6, b"Blb", b"bulb", b"A reversed blub to get back in time before it reaches Million MC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015187_3ef2a66124.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLB>>(v1);
    }

    // decompiled from Move bytecode v6
}

