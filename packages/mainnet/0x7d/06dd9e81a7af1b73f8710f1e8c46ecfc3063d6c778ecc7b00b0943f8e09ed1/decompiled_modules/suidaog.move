module 0x7d06dd9e81a7af1b73f8710f1e8c46ecfc3063d6c778ecc7b00b0943f8e09ed1::suidaog {
    struct SUIDAOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDAOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDAOG>(arg0, 6, b"SUIDAOG", b"SuiDaog", b"SuiDaog - meme coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001042_635e6ec273.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDAOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDAOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

