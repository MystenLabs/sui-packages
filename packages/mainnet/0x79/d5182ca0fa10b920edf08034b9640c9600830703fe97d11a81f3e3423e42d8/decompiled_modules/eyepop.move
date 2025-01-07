module 0x79d5182ca0fa10b920edf08034b9640c9600830703fe97d11a81f3e3423e42d8::eyepop {
    struct EYEPOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYEPOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYEPOP>(arg0, 6, b"EYEPOP", b"Eye pop SUI", b"EYEPOP the most eye-popping and eye-catching memecoin in existence on Sui. It will pop your eyes out! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241212_173522_125_e948e0eda8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYEPOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EYEPOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

