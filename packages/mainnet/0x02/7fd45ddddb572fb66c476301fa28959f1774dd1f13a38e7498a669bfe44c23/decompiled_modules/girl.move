module 0x27fd45ddddb572fb66c476301fa28959f1774dd1f13a38e7498a669bfe44c23::girl {
    struct GIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GIRL>(arg0, 6, b"GIRL", b"Girlcrypto", b"@suilaunchcoin @SuiAIFun @suilaunchcoin $GIRL + Girlcrypto https://t.co/DyyNS0eRd5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/girl-pq6fnq.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GIRL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIRL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

