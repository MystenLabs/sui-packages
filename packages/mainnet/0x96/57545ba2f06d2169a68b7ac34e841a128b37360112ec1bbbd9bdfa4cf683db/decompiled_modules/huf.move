module 0x9657545ba2f06d2169a68b7ac34e841a128b37360112ec1bbbd9bdfa4cf683db::huf {
    struct HUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUF>(arg0, 6, b"HUF", b"Huckleberry Fish", b"Huckleberry Fish is a rainbow wonder poised to grow on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0556_4b8b1a62ac.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUF>>(v1);
    }

    // decompiled from Move bytecode v6
}

