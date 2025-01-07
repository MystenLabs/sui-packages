module 0x16a396ffd60c8095f6bb063aab6de394668837357882957e003784433ce676f5::robotx {
    struct ROBOTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOTX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOTX>(arg0, 6, b"RobotX", b"RoboTaxi", b"Celebrates the Elon musk new innovation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3361_341f50d409.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOTX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBOTX>>(v1);
    }

    // decompiled from Move bytecode v6
}

