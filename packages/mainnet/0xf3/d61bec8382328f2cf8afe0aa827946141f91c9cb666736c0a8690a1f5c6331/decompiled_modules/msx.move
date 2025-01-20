module 0xf3d61bec8382328f2cf8afe0aa827946141f91c9cb666736c0a8690a1f5c6331::msx {
    struct MSX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSX>(arg0, 6, b"MSX", b"MSX Coin", b"Moviepass Stock Exchange Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d1fvsuv3rrz9o2.cloudfront.net/dogs/bone.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

