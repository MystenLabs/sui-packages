module 0xe2da2f0ed96fec4d12f7dd6d3d983618c9e7d3e4e6db826df1d07d597c5bd79b::rts {
    struct RTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTS>(arg0, 6, b"RTS", b"Red skull on sui", b"The first skull on sui and bluemove", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036840_c25ddd7354.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

