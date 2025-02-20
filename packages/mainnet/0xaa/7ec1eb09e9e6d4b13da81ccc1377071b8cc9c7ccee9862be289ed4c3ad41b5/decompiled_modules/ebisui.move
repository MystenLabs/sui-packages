module 0xaa7ec1eb09e9e6d4b13da81ccc1377071b8cc9c7ccee9862be289ed4c3ad41b5::ebisui {
    struct EBISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EBISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EBISUI>(arg0, 6, b"EBISUI", b"Ebisui", b"Meet Ebisui, the ultimate harbinger of good vibes on the Sui Blockchain! This isn't your average deity; he's the god of good fortune from Japan, now reimagined for the crypto world. With his infectious smile, fisherman's garb, Ebisui is here to reel in prosperity, luck, and non-stop wins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4565_b1ac186d44.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EBISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EBISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

