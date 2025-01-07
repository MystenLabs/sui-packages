module 0x69874b337cdbeeab561f370356bb4c56235e952eb02da5491dacfd46c86f9f67::bullshark {
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

