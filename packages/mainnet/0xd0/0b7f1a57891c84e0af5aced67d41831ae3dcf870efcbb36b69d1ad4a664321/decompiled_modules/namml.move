module 0xd00b7f1a57891c84e0af5aced67d41831ae3dcf870efcbb36b69d1ad4a664321::namml {
    struct NAMML has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMML>(arg0, 6, b"NAMML", b"Nammlol", b"dfdcfd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HJ_844bd97167.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAMML>>(v1);
    }

    // decompiled from Move bytecode v6
}

