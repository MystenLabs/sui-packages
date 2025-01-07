module 0x88e7b4fd4c11a7a9a8f94b0f435a4e19c4db196fb458bfed604d4dfcbc39096b::hopper {
    struct HOPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPER>(arg0, 6, b"Hopper", b"Hopper the rabbit", b"the fastest coin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hopper_pfp_f03c429445_e9cf6f3d14.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

