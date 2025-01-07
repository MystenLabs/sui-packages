module 0x3f17ae4b8a263a5216c0cacd3c20a4973faf8ab4c58327d44830d66ca8cecbe::suigod {
    struct SUIGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOD>(arg0, 6, b"SUIGOD", b"Sui God", b"The God meme of Sui chain. Worship the culture of memes on sui inspired with creator of Sui Evan.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241008_161951_481_ca7a9c937b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

