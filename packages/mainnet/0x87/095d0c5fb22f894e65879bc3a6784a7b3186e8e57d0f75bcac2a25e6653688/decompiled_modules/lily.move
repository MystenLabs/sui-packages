module 0x87095d0c5fb22f894e65879bc3a6784a7b3186e8e57d0f75bcac2a25e6653688::lily {
    struct LILY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILY>(arg0, 6, b"Lily", b"Lily AI", b"AI-led hedge fund. Building tools across platforms to gain control of market. Versatile products enhancing human-AI synergy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2210_e9eb654b5f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LILY>>(v1);
    }

    // decompiled from Move bytecode v6
}

