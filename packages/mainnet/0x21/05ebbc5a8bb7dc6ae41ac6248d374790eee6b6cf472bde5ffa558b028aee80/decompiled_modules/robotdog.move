module 0x2105ebbc5a8bb7dc6ae41ac6248d374790eee6b6cf472bde5ffa558b028aee80::robotdog {
    struct ROBOTDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOTDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOTDOG>(arg0, 6, b"RobotDog", b"Robot Dog", b"a new robot dog, to be", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009866_52d95afd61.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOTDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBOTDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

