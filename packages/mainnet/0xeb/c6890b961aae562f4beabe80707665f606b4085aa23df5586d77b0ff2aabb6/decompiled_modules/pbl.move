module 0xebc6890b961aae562f4beabe80707665f606b4085aa23df5586d77b0ff2aabb6::pbl {
    struct PBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"nPEEBLE";
        0x1::vector::remove<u8>(&mut v0, 0);
        let v1 = x"64506565626c65206973206a757374206120726f636b2e20f09faaa80a426f726e20746f20646f206162736f6c7574656c79206e6f7468696e672c20697420726f6c6c6564206f6e746f2074686520626c6f636b636861696e20746f2065736361706520746865206368616f732e204e6f207574696c6974792c206e6f20726f61646d61702c20636f6d706c6574656c7920756e626f7468657265642e205768696c65206f74686572732074727920746f20666c7920746f20746865206d6f6f6e2c20506565626c65206a7573742073697473206f6e207468652067726f756e64";
        0x1::vector::remove<u8>(&mut v1, 0);
        let (v2, v3) = 0x2::coin::create_currency<PBL>(arg0, 6, b"PBL", v0, v1, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suidot.fun/i/Nu-fxKRJrTQvhqM8")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PBL>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PBL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

