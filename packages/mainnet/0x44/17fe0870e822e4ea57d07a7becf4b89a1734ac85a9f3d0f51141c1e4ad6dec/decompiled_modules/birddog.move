module 0x4417fe0870e822e4ea57d07a7becf4b89a1734ac85a9f3d0f51141c1e4ad6dec::birddog {
    struct BIRDDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDDOG>(arg0, 6, b"BIRDDOG", b"BIRD DOG CLUB", b"Birddogs Boys Club is redefining the intersection of memes and culture.Be careful with fraudulent contracts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_9b78ec9e64.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRDDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRDDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

