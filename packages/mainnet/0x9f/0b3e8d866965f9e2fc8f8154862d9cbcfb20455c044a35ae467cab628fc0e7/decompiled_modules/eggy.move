module 0x9f0b3e8d866965f9e2fc8f8154862d9cbcfb20455c044a35ae467cab628fc0e7::eggy {
    struct EGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGY>(arg0, 6, b"EGGY", b"Eggy the pet", b"Eggy the uncrackable", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241008_234055_16aefe2463.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

