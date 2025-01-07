module 0xe311716479147f0020eade6c218f5befbdcfaf91bdacdf708ff17b5fc7b3c58b::skl {
    struct SKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKL>(arg0, 6, b"SKL", b"Seal killer", b"Seal killer coin wants to beat the Seal!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_51c138767d.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

