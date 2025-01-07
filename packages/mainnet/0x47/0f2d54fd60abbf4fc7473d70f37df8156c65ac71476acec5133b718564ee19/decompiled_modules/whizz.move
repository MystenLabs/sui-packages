module 0x470f2d54fd60abbf4fc7473d70f37df8156c65ac71476acec5133b718564ee19::whizz {
    struct WHIZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHIZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHIZZ>(arg0, 6, b"WHIZZ", b"WHIZZ, THE SEA HERO", b"Whizz, the Newfoundland was trained to rescue people from the water. He saved nine humans and one other dog from drowning over the course of his life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/089_CDBD_1_EF_79_4_B06_8_CC_9_005648_C361_E2_f3da108cb4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHIZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHIZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

