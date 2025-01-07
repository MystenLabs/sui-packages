module 0xebc057a2fcf3419e363619c6b234b04e194d7e5c1c706c1c16e8a252e384cd05::hes {
    struct HES has drop {
        dummy_field: bool,
    }

    fun init(arg0: HES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HES>(arg0, 6, b"HES", b"Heiko sui", b"Heiko sui is a new memecoin join us ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0079_6aa4753a11.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HES>>(v1);
    }

    // decompiled from Move bytecode v6
}

