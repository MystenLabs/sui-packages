module 0x244b8892ea26c0e03b4f8ff1c1931a8ac42a39bd2c44b9b84b4c39a2cceb8f70::guychill {
    struct GUYCHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUYCHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUYCHILL>(arg0, 6, b"GUYCHILL", b"Guy Chill On Sui", b"Just a guy chill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avarta_4d39c06831.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUYCHILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUYCHILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

