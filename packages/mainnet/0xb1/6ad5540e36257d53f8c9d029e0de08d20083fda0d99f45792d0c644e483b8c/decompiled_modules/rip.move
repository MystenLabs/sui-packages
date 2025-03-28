module 0xb16ad5540e36257d53f8c9d029e0de08d20083fda0d99f45792d0c644e483b8c::rip {
    struct RIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIP>(arg0, 6, b"RIP", b"Rip Walrus", b"End of walrus era", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051463_b501d87b8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

