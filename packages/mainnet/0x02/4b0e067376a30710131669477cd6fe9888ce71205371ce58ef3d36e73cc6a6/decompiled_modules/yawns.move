module 0x24b0e067376a30710131669477cd6fe9888ce71205371ce58ef3d36e73cc6a6::yawns {
    struct YAWNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAWNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAWNS>(arg0, 6, b"YAWNS", b"Laziest Meme", x"4d65657420245941574e2c2074686520736c65657069657374206d656d65626572206f66207468652067726f7570202e2048652077617320736f206465657020696e20736c756d6265722074686174206865206d69737365642074686520696e7669746174696f6e20746f206a6f696e2074686520426f79277320436c75622c206120726567726574206865732063617272696564206576657273696e63652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_2bfb4e8fce.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAWNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAWNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

