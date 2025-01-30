module 0x65479405da44c1f4e31ef168745e63042dde685d77d396505773395260aebf3::flame {
    struct FLAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAME>(arg0, 6, b"FLAME", b"#PalisadesFire", b"#PalisadeFire is the blazing-hot memecoin inspired by the first enviromental disaster in 2025. Fueled by fiery memes and a passion for decentralization.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250130_232026_585_2766eee507.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

