module 0x18fea239cf8a2d5e2ede35a878c06156b92ca2aca1aa73f131e5a1ba61fd86d2::piss {
    struct PISS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PISS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PISS>(arg0, 6, b"PISS", b"Pussy In Sport Shoes", b"Pussy in Sport Shoes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030680_049ccf8f36.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PISS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PISS>>(v1);
    }

    // decompiled from Move bytecode v6
}

