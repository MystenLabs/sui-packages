module 0x47a21c380e59a6dabc4aef953b2d7e68e2ee1e1b09892b474606ba63f39834cd::odd {
    struct ODD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODD>(arg0, 6, b"ODD", b"ODD DUCK", b"Be Different - Build and support eachother ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9527_00ede57492.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ODD>>(v1);
    }

    // decompiled from Move bytecode v6
}

