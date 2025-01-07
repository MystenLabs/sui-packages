module 0xbe58f859150377ad15c41b44bd1a87e59fedce4b19c5619c3a49ef8af5718eab::glock {
    struct GLOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOCK>(arg0, 6, b"GLock", b"Gorlock", b"The biggest whale that has ever existed, on the water chain, no socials for now, I just find it funny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7879_cfce00e5a4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

