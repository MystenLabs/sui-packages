module 0xdc19edf98470aad1252460d712bdc068585f525055b24772aaa1ee7bd0038139::spoi {
    struct SPOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOI>(arg0, 9, b"SPOI", b"SUI (Bridge on: suibridgev2.com)", b"sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s3.coinmarketcap.com/static-gravity/image/5bd0f43855f6434386c59f2341c5aaf0.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPOI>(&mut v2, 10000000000 * 0x1::u64::pow(10, 9), 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOI>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

