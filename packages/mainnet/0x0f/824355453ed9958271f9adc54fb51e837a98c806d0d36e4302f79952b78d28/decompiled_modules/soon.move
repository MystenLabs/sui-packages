module 0xf824355453ed9958271f9adc54fb51e837a98c806d0d36e4302f79952b78d28::soon {
    struct SOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOON>(arg0, 6, b"SOON", b"When TGE", b"When TGE ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241123_210457_864_d3ed8c92ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

