module 0xf2a5dc86a9adb27ea27eb6b35763a53cd1edd2c518018a1899c6e6831fe811a7::magna {
    struct MAGNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGNA>(arg0, 6, b"Magna", b"MagnaAI", b"Magna redefines creativity with AI-driven art, turning your ideas into stunning visuals effortlessly.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2236_02c8a0c7e3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

