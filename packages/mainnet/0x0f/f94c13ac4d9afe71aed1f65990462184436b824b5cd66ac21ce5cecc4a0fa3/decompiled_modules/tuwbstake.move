module 0xff94c13ac4d9afe71aed1f65990462184436b824b5cd66ac21ce5cecc4a0fa3::tuwbstake {
    struct TUWBSTAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUWBSTAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUWBSTAKE>(arg0, 6, b"Tuwbstake", b"Suirloin Dion", b"Come grab a bag of Tuwbstake! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5944_66b491d991.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUWBSTAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUWBSTAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

