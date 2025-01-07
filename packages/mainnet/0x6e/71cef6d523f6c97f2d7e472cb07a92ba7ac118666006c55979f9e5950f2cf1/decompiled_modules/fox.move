module 0x6e71cef6d523f6c97f2d7e472cb07a92ba7ac118666006c55979f9e5950f2cf1::fox {
    struct FOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOX>(arg0, 6, b"Fox", b"foxgirl", b"this is foxgirl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fox_dxsale_485bf43bad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

