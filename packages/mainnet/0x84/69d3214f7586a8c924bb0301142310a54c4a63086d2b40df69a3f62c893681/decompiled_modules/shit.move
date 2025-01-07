module 0x8469d3214f7586a8c924bb0301142310a54c4a63086d2b40df69a3f62c893681::shit {
    struct SHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIT>(arg0, 6, b"SHIT", b"TURD", b"The Crypto That Keeps Crapping, TURD will be the utility token of the TURD ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TURD_b3d26c3383.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

