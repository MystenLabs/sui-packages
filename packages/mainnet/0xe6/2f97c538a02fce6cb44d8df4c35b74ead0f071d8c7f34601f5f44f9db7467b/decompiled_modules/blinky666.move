module 0xe62f97c538a02fce6cb44d8df4c35b74ead0f071d8c7f34601f5f44f9db7467b::blinky666 {
    struct BLINKY666 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLINKY666, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLINKY666>(arg0, 6, b"BLINKY666", b"SUI_BLINKY_666", b"3 eyes as 3 letters in SUI SUI x MEME x BASED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3eye_7bfbea8e1d_becb72c7dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLINKY666>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLINKY666>>(v1);
    }

    // decompiled from Move bytecode v6
}

