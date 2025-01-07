module 0xa9d64e3f439e884632975f0b21c6b4483349c48c83fbd29e43d82fea36893f43::minichen {
    struct MINICHEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINICHEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINICHEN>(arg0, 6, b"MINICHEN", b"MINICHEN SUI", b"If you only do what you can do, you'll never be more than you are now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MINICHEN_83ea346f59.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINICHEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINICHEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

