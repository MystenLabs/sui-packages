module 0x96e6324acc19147d8a5db18b3d2d15bc74747c03b777430675f1ee4cd287df9d::azur {
    struct AZUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZUR>(arg0, 6, b"AZUR", b"azur cryptus sui", b"He has a tail that resembles a lightning bolt, symbolizing the speed of transactions, and his paws emit a soft glow when he's actively working on saving crypto assets. His mission is to fight cybercriminals and protect the digital currency world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250110_025622_594_152f77bab8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AZUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

