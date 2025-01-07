module 0xb640b8b836ba3dd43d2faf29b82ae4576f20f87a98995ebb71691917c80dfe3a::niko {
    struct NIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIKO>(arg0, 6, b"NIKO", b"niko", b"It's a pure meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12456_a5351312ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

