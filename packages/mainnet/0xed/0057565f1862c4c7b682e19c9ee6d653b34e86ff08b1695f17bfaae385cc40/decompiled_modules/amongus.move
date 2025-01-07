module 0xed0057565f1862c4c7b682e19c9ee6d653b34e86ff08b1695f17bfaae385cc40::amongus {
    struct AMONGUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMONGUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMONGUS>(arg0, 6, b"AMONGUS", b"Among Sui", b"$AMONGSUI - A MEME COIN iNSPIRED BY AMONG US", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000261_1d0bad9797.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMONGUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMONGUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

