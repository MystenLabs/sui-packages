module 0xb88eaf0cba99b94a4eaa190b1fd4f6f272834fa769c4e693d3bb2d4a651fafd5::suiczu {
    struct SUICZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICZU>(arg0, 6, b"SUICZU", b"SuiCzu", b"SuiCzu the breed found only on the Sui network, its so rare it only appears every 10th generation of Shih tzu families, don't let this be unnoticed!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_91b1950d6a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICZU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICZU>>(v1);
    }

    // decompiled from Move bytecode v6
}

