module 0x84f59c83e004740fb46c4f9964e15b3daec56bffda6764677611be7e7ac38f38::bullger {
    struct BULLGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLGER>(arg0, 6, b"BullGer", b"BullishBadger", x"4042756c6c697368426164676572436f0a68747470733a2f2f6c696e6b74722e65652f42756c6c6973684261646765722020202020202020466561726c6573732c2052656c656e746c6573732c2042756c6c697368212043686172676520416865616420776974682042756c6c69736842616467657221", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/o_F_Dtyrk_R_400x400_d5065acd1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

