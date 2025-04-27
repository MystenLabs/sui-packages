module 0xc33111addbca7db490f3738722ade3f87ce9e45505788fec4709ffddeafaac80::spresso {
    struct SPRESSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRESSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPRESSO>(arg0, 6, b"SPRESSO", b"SUI SPRESSO", x"5350524553534f2054484520524f424f20425544445920424152495354410a0a412043454c4542524154494f4e204f4620535549204d4f5645204f5320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SDESG_6d287ae75c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPRESSO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPRESSO>>(v1);
    }

    // decompiled from Move bytecode v6
}

