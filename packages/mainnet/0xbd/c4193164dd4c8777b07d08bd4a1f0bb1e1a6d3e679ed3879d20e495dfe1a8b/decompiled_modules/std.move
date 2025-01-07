module 0xbdc4193164dd4c8777b07d08bd4a1f0bb1e1a6d3e679ed3879d20e495dfe1a8b::std {
    struct STD has drop {
        dummy_field: bool,
    }

    fun init(arg0: STD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STD>(arg0, 6, b"STD", b"Suitard", b"Suitardio hall of fame | A tribute to all retard(io)s on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015610_84d7ba3859.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STD>>(v1);
    }

    // decompiled from Move bytecode v6
}

