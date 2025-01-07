module 0x6eb14c175ff968512cecc6b472dee75f17371eb8f786640f458883d5a156e1df::top {
    struct TOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOP>(arg0, 6, b"TOP", b"TOPSUI", b"Unveiling TOP PROTOCOL, DEFI 4.0, New dual pool protection mechanism!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9n_Cxl_E8u_400x400_824f0d260b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

