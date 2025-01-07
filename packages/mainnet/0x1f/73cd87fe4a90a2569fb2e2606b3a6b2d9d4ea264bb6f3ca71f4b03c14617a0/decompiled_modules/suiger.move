module 0x1f73cd87fe4a90a2569fb2e2606b3a6b2d9d4ea264bb6f3ca71f4b03c14617a0::suiger {
    struct SUIGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGER>(arg0, 6, b"Suiger", b"SUGER ON SUI", b"Well, look who decided to drop by! Youve just found the most fabulous thing on the internet me.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Mme9_U8_Q_400x400_18f4342348.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

