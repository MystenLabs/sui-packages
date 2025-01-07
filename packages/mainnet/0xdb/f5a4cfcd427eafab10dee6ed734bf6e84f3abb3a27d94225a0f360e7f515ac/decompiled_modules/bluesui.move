module 0xdbf5a4cfcd427eafab10dee6ed734bf6e84f3abb3a27d94225a0f360e7f515ac::bluesui {
    struct BLUESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUESUI>(arg0, 6, b"BLUESUI", b"The Blue Chicken Sui", x"4b6977692054686520426c756520436869636b656e20697320746865206d6f73742066616d6f757320626c75652062697264206f6e2054696b546f6b2c20616d617373696e67206f76657220353030206d696c6c696f6e20766965777320616e6420322e38206d696c6c696f6e20666f6c6c6f776572732e2046616e206d6164653a204b697769206d616b65732068697320666972737420646562757420696e2043727970746f20616e64206c65617665732068697320636c61777072696e747320666f7265766572206f6e207468652053756920626c6f636b636861696e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241202_145337_340_ec3e73d3af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

