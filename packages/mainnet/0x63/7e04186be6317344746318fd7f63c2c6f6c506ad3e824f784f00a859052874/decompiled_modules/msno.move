module 0x637e04186be6317344746318fd7f63c2c6f6c506ad3e824f784f00a859052874::msno {
    struct MSNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSNO>(arg0, 6, b"MSNO", b"Missingno", x"4d697373696e674e6f2e2062726f6b65207468652067616d65e280946974207761736ee2809974206120666561747572652074686174207761732064657369676e65642c2062757420697420626563616d6520736f6d657468696e672070656f706c65206c6f76656420626563617573652069742077617320736f206f7574206f6620746865206f7264696e6172792e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735083718277.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSNO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSNO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

