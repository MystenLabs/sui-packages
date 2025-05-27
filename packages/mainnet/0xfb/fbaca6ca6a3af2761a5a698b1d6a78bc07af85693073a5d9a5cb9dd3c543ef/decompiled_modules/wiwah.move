module 0xfbfbaca6ca6a3af2761a5a698b1d6a78bc07af85693073a5d9a5cb9dd3c543ef::wiwah {
    struct WIWAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIWAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIWAH>(arg0, 6, b"WIWAH", b"WHAT IF WE ALL HELD", b"What if we all held?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7273_8e26c21f15.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIWAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIWAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

