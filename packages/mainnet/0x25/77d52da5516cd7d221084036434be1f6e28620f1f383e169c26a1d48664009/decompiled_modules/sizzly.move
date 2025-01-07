module 0x2577d52da5516cd7d221084036434be1f6e28620f1f383e169c26a1d48664009::sizzly {
    struct SIZZLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIZZLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIZZLY>(arg0, 6, b"SIZZLY", b"SUIZZLY BEAR", b"Polar bear sizzly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3829_eaec4497a4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIZZLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIZZLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

