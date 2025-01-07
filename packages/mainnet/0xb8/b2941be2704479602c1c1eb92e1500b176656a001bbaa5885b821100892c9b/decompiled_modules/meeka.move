module 0xb8b2941be2704479602c1c1eb92e1500b176656a001bbaa5885b821100892c9b::meeka {
    struct MEEKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEEKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEEKA>(arg0, 6, b"MEEKA", b"MEEKA ON SUI", b"Meeka is a popular and highly followed Husky on TikTok and Youtube.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/meka_d47d38fcc1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEEKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEEKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

