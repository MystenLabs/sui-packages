module 0xc0c10c1e30ccbc038d9807ada29a86c576027296e663f570e369e2ee998e201::wojak {
    struct WOJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOJAK>(arg0, 6, b"Wojak", b"Wojak On Sui", x"576f6a616b206973206f6666696369616c6c79206f6e205375692e200a4e6f206d6f726520496d706f73746572732e0a546865206f6e6520616e64204f4e4c59204f4720574f4a414b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9213_4bb4567510.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOJAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOJAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

