module 0x969955880018285f232448e421fd148e6cf2414064cf28d640e6512cede73c9b::pumptober {
    struct PUMPTOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPTOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPTOBER>(arg0, 6, b"PUMPTOBER", b"PUMPTOBER ON SUI", b"WHAT'S UP, WHAT'S GOING ON? MISSED MICHI, WEN, MANEKI OR NUB? WANNA EARLY ALPHA? AHAHAH! YOU LAST CHANCE IS TO APE $PUMPTOBER - THE BEST FROM EACH ONE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pic_1_152903b358.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPTOBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPTOBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

