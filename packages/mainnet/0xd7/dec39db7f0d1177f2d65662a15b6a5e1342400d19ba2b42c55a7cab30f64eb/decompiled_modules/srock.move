module 0xd7dec39db7f0d1177f2d65662a15b6a5e1342400d19ba2b42c55a7cab30f64eb::srock {
    struct SROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SROCK>(arg0, 6, b"SRock", b"Sui Sea Rock", x"5375692053656120526f636b0a526f636b206f6e20537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rock_Under_959f37d86e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SROCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

