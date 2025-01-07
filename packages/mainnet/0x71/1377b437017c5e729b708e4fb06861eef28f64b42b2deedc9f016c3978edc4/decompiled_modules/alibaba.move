module 0x711377b437017c5e729b708e4fb06861eef28f64b42b2deedc9f016c3978edc4::alibaba {
    struct ALIBABA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALIBABA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALIBABA>(arg0, 6, b"ALIBABA", b"Ali Baba on Sui", b"If you have never tried it, how can you know if theres a chance to Open Sesame? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5664_56684f8774.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALIBABA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALIBABA>>(v1);
    }

    // decompiled from Move bytecode v6
}

