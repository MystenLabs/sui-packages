module 0x8c8d6319670c359d543efe8d60f737865589547be4cfd67b5bc0bb77d352aa5d::shremp {
    struct SHREMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHREMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHREMP>(arg0, 6, b"SHREMP", b"SHREMPIN", x"49276d2073657420746f2065636c6970736520506570652120427261636520796f757273656c76657320666f7220696e74657267616c6163746963206c6175676873207769746820536872656d70696e206d656d65732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_18_15_05_41_0976d744a9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHREMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHREMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

