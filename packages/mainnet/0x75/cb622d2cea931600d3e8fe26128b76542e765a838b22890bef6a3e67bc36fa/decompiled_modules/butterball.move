module 0x75cb622d2cea931600d3e8fe26128b76542e765a838b22890bef6a3e67bc36fa::butterball {
    struct BUTTERBALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTTERBALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUTTERBALL>(arg0, 6, b"Butterball", b"ButterBall", b"tiktok.com/@butterballthatsme?lang=en", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052936_31d70b5da8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUTTERBALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUTTERBALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

