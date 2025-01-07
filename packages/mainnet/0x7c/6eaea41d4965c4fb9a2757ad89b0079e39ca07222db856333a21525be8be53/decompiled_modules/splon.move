module 0x7c6eaea41d4965c4fb9a2757ad89b0079e39ca07222db856333a21525be8be53::splon {
    struct SPLON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLON>(arg0, 6, b"SPLON", b"SPLO NINJA", b"All in, all splash. Sorry, which way ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/splooo_1a7cf7c981.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPLON>>(v1);
    }

    // decompiled from Move bytecode v6
}

