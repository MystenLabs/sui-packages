module 0xea32c8a2ed1d90e61204dfb2c39eef67f648144b2c8863dc5e25a1c16956877a::sk {
    struct SK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SK>(arg0, 6, b"SK", b"Sherk knife", b"get out my space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1609e8f01b4d27b7f0d52567cb47375c_640b4cfd73.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SK>>(v1);
    }

    // decompiled from Move bytecode v6
}

