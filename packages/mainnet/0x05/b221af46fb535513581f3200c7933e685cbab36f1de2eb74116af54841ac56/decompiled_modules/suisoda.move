module 0x5b221af46fb535513581f3200c7933e685cbab36f1de2eb74116af54841ac56::suisoda {
    struct SUISODA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISODA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISODA>(arg0, 6, b"SuiSoda", b"SuiSODA", b"i m sui soda drink drink", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fd80a485_fb40_48ec_ba8a_90c41ed04334_e3846d8ed8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISODA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISODA>>(v1);
    }

    // decompiled from Move bytecode v6
}

