module 0xd7a0c511f5435a0f169d770bd194db0ded13b5c19a4c5df085016aee6be7bbb4::lamo {
    struct LAMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMO>(arg0, 9, b"LAMO", b"LAMOToken", x"4c414d4f546f6b656e2069732061206d656d652d64726976656e2063727970746f63757272656e6379206272696e67696e67206c617567687320746f207468652063727970746f20776f726c642e205769746820612066756e20636f6d6d756e69747920616e64206120666f637573206f6e20656e7465727461696e6d656e742c204c414d4f546f6b656e2061696d7320746f20737072656164206a6f79207768696c6520796f7520484f444c2e204a6f696e20757320617320776520726964652074686520726f636b6574206f66206c617567687320616c6c207468652077617920746f20746865206d6f6f6e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0012da7b-9c96-4cb0-889a-34c5e9f818eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

