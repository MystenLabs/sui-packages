module 0x21d524214c04f257d5c95d6d7cbd226d83b8c428cc79afa8ecafa21b84b652c::dpixel {
    struct DPIXEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPIXEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPIXEL>(arg0, 6, b"DPIXEL", b"Diamond Pixel", b"beetwen the pixel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028237_5495c94f2e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPIXEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DPIXEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

