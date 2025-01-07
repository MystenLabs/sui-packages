module 0x27684671ec3643758679184c4952ed6d30883b5cb2577da989a28dff2b1d6713::lfd {
    struct LFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LFD>(arg0, 6, b"LFD", b"Landfather donvito", b"Your meme family is everything", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241202_144655_965_e385750742.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

