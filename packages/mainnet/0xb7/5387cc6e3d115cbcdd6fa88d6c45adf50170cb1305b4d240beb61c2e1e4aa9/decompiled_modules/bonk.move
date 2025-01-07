module 0xb75387cc6e3d115cbcdd6fa88d6c45adf50170cb1305b4d240beb61c2e1e4aa9::bonk {
    struct BONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONK>(arg0, 6, b"BONK", b"BONKERS", x"24424f4e4b2c2057652068617665206e6f20616666696c696174696f6e207769746820426f6e6b202c206a7573742061207465616d206f6620686f6c646572732077697468206120766973696f6e20746f206576656e206675727468657220696e63726561736520426f6e6b27732070726573656e636520696e20746865206d61726b65742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bonkers_d7412494e1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

