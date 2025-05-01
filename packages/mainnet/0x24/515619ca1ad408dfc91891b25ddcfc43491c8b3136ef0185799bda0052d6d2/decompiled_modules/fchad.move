module 0x24515619ca1ad408dfc91891b25ddcfc43491c8b3136ef0185799bda0052d6d2::fchad {
    struct FCHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCHAD>(arg0, 6, b"FCHAD", b"FOMOCHAD", b"https://x.com/FomoFrien", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ffdffffff_e97c735ece.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FCHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

