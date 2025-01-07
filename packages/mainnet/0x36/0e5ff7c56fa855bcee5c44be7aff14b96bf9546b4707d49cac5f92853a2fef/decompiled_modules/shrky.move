module 0x360e5ff7c56fa855bcee5c44be7aff14b96bf9546b4707d49cac5f92853a2fef::shrky {
    struct SHRKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRKY>(arg0, 6, b"SHRKY", b"Sharky", b"Swimming my way through the SUI eco system", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735276704631.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHRKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

