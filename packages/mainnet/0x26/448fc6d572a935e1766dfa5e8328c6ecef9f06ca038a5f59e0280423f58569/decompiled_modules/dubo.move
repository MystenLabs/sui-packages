module 0x26448fc6d572a935e1766dfa5e8328c6ecef9f06ca038a5f59e0280423f58569::dubo {
    struct DUBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUBO>(arg0, 6, b"Dubo", b"Dubo <>", b"X @duboondub", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fafsasfsfsfa_9a5c741de9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

