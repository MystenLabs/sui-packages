module 0xeba25f94e8ee7dd16eef068c679623c4aa7de6bd459e14018b50ec5ed450e81d::do {
    struct DO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DO>(arg0, 6, b"DO", b"c'mon", b"C'mon, do something...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/R_5b80d9da08.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DO>>(v1);
    }

    // decompiled from Move bytecode v6
}

