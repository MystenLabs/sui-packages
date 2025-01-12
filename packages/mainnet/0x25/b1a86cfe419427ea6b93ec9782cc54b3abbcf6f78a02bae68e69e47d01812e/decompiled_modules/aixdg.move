module 0x25b1a86cfe419427ea6b93ec9782cc54b3abbcf6f78a02bae68e69e47d01812e::aixdg {
    struct AIXDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIXDG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIXDG>(arg0, 6, b"AIXDG", b"aixdg by SuiAI", b"AIXDG monitors CT discussions and utilizes its proprietary engine to identify high-momentum opportunities while engaging with games on the Sui Network...Holders of the AIXDG token gain exclusive access to its advanced analytics platform.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/aixd_d65c4306bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIXDG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIXDG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

