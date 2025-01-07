module 0x114c27ac4dccaf026d0ee952aed9e191d79e3a7f2649c764a36bcec10885fac0::jaws {
    struct JAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAWS>(arg0, 6, b"JAWS", b"BLUE JAWS", b"$JAWS IS CUTE SHARK MASCOT ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3768_d363504f6b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

