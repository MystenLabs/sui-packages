module 0xa92555044df924ca23bd0122b4fb10ad352dc1d9fadbc1572431d4101bd37916::logmog {
    struct LOGMOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOGMOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOGMOG>(arg0, 6, b"LOGMOG", b"Half Log Half Mog", b"Grow your bags. Water your $LOGMOG.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logmog_640x640_c715a7e4df.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOGMOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOGMOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

