module 0xe8396e1047c1dc0c7f3dcd76789b53ef5a99fedcbfe1acf29d455b26aa5b5db7::lsd {
    struct LSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LSD>(arg0, 6, b"LSD", b"Liquid Sui derivative 42069", b"$LSD is a revolutionary blockchain cryptography token revolutionizing the realm of digital assets and scientific exploration on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001051878_a36c5cb11b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

