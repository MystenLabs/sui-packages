module 0x4600d0b203bcd84a870ee8d920f8fbc14eaa652382aab6fb6a22463d70bd65c5::suitree {
    struct SUITREE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITREE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUITREE>(arg0, 6, b"SUITREE", b"Suitree by SuiAI", b"Suitree", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000005870_026068fd41.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUITREE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITREE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

