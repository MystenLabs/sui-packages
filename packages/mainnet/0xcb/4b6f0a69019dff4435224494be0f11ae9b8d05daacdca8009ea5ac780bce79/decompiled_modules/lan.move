module 0xcb4b6f0a69019dff4435224494be0f11ae9b8d05daacdca8009ea5ac780bce79::lan {
    struct LAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAN>(arg0, 6, b"LAN", b"Mouri Lan", b"I'm Mouri Lan !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0044_3e808d5530.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

