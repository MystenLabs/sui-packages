module 0x8a15cf8c9555394cd8805991e29380f96b7b27c6554508bf8ad7a9c94f0e9fc7::baldpepe {
    struct BALDPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALDPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALDPEPE>(arg0, 6, b"BALDPEPE", b"Bald Pepe", b"DeFi project on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12_2bd69af66f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALDPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALDPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

