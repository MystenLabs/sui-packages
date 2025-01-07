module 0xa517c652d717a51eab0614ce22d23bea77990f975895ae7ce27985c9422003d8::hank {
    struct HANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANK>(arg0, 6, b"Hank", b"PetsofMSTR", x"4d6565742048616e6b2c206f7572206e6577657374206d6173636f742e200a5468617427732069742c207468617427732074686520706f73742e0a0a23506574736f664d53545220234d6f6465726e416e616c797469637320234249", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000228347_ea9df63a74.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

