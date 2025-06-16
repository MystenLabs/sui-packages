module 0x4db8b2a828f5e7ebc22d09baa621aa5568adff128b54bcf7efb5617c6124616f::play {
    struct PLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLAY>(arg0, 6, b"PLAY", b"Meme Play AI", b"Play games built by AI or chat with your AI friends always here, always ready, whenever you want. Hours of fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7082_2217127847.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

