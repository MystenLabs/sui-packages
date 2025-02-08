module 0x1cf763f1fba249d79c3d33ed2a4464d8a5db42cc5d57de9d36463446df04d1bd::dng {
    struct DNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNG>(arg0, 6, b"Dng", b"Dengue", b"Came to suck ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038597_ba2538d220.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

