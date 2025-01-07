module 0xac133a8566eedc496d17c932b7cb8588560fc0fca7296c503bdbcbe14d4eb5d::whizz {
    struct WHIZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHIZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHIZZ>(arg0, 6, b"WHIZZ", b"WHIZZ THE SEA HERO", b"Whizz the Newfoundland was trained to rescue people from the water. He saved nine humans and one other dog from drowning over the course of his life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/089_CDBD_1_EF_79_4_B06_8_CC_9_005648_C361_E2_f0a93ba6ba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHIZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHIZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

