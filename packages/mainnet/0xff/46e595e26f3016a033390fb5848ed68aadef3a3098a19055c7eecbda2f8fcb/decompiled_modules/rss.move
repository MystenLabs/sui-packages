module 0xff46e595e26f3016a033390fb5848ed68aadef3a3098a19055c7eecbda2f8fcb::rss {
    struct RSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSS>(arg0, 6, b"RSS", b"RABBIT SHARK SUI", x"5420522055205320542049204e2054204820452053204820412052204b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HTE_4w_U_Jd_400x400_2545efc506.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

