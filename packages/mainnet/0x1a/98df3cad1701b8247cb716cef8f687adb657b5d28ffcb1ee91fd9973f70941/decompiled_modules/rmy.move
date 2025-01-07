module 0x1a98df3cad1701b8247cb716cef8f687adb657b5d28ffcb1ee91fd9973f70941::rmy {
    struct RMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RMY>(arg0, 6, b"RMY", b"Rummy Gamez", b"Rummy Gamez provides a platform for gamers and card fanatics to play, invest, and win. Transforming traditional games into blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_13_59_18_b9e17118a2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

