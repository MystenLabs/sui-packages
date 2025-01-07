module 0x4e85191ffdb757551b7e92528e3576a98cd85546e30d8cb5c5434498cf8af932::bullshark {
    struct BULLSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLSHARK>(arg0, 6, b"BULLSHARK", b"Bullshark", b"No socials just send it no scams no bullshit just bullshark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5966_3715d54cf1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLSHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

