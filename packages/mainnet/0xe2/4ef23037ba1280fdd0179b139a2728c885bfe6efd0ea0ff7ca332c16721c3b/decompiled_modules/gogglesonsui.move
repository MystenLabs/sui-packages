module 0xe24ef23037ba1280fdd0179b139a2728c885bfe6efd0ea0ff7ca332c16721c3b::gogglesonsui {
    struct GOGGLESONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOGGLESONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOGGLESONSUI>(arg0, 6, b"GOGGLESONSUI", b"GOGGLES", x"4f6e63652075706f6e206120626c6f636b636861696e20496e206120776f726c64206f662063727970746f206368616f732c20776865726520746f6b656e7320636f6d6520616e6420676f20666173746572207468616e20796f7572206d6f726e696e6720636f666665652c206f6e6520746f6b656e20726f73652061626f766520746865206e6f6973652e20474f47474c45532e204e6f74206a7573742061206e616d652c20627574206120766973696f6e2e204120746f6b656e207468617420646172656420746f207361792c205765207365652077686174206f746865727320646f6e742e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/penguin_cad03810d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOGGLESONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOGGLESONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

