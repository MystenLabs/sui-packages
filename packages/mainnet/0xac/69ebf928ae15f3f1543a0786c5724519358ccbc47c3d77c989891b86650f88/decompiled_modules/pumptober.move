module 0xac69ebf928ae15f3f1543a0786c5724519358ccbc47c3d77c989891b86650f88::pumptober {
    struct PUMPTOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPTOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPTOBER>(arg0, 6, b"PUMPTOBER", b"PUMPTOBER ON SUI", b"WHAT'S UP, WHAT'S GOING ON? MISSED MICHI, WEN, MANEKI OR NUB? WANNA EARLY ALPHA? AHAHAH! YOU LAST CHANCE IS TO APE $PUMPTOBER - THE BEST FROM EACH ONE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pic_2_f71e6d264a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPTOBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPTOBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

