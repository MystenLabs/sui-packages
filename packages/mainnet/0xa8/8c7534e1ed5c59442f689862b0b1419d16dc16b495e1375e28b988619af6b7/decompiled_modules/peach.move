module 0xa88c7534e1ed5c59442f689862b0b1419d16dc16b495e1375e28b988619af6b7::peach {
    struct PEACH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEACH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEACH>(arg0, 6, b"PEACH", b"PeachCat on Sui", b"The Official Launch of Peach Cat on Sui! Welcome to the adventures of the Peach Cat comm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/openart_491a07f3a3bc46c1a0a86214acbff459_raw_0640bac906.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEACH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEACH>>(v1);
    }

    // decompiled from Move bytecode v6
}

