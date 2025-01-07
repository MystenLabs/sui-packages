module 0x51ff1ab4034bec3dda3cdfda95713e5dcba0b918549776e25e360e7565b50dce::whalealert {
    struct WHALEALERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALEALERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALEALERT>(arg0, 6, b"WhaleAlert", b"Sui Whale Alert", x"407375696e6574776f726b0a204461696c79205768616c6520416c65727473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3060_8dbcadaed7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALEALERT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALEALERT>>(v1);
    }

    // decompiled from Move bytecode v6
}

