module 0x842abcce962c78fbbcec66a2a3a07c1651d168f065e62c461dde37da953a176d::chillpepe {
    struct CHILLPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLPEPE>(arg0, 6, b"CHILLPEPE", b"Chill Pepe Sui", b"Just a blue dude chillin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chillpepe_cef30a976d.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

