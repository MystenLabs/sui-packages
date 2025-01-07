module 0x4c8dae425dcd3ab54f137dad52abe9e06a4c5ca4e0c82d83a2c6a7e659bc682f::adhd {
    struct ADHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADHD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADHD>(arg0, 6, b"ADHD", b"ADHD ON SUI", b"Reject Productivity, Embrace $ADHD.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241223_230331_110_8c3999cfc2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADHD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADHD>>(v1);
    }

    // decompiled from Move bytecode v6
}

