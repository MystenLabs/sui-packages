module 0x49ff613775281910c339702abad4bfd3336758fbf17764fa748ddacf4076186d::suigirl {
    struct SUIGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGIRL>(arg0, 6, b"SUIGIRL", b"SUI GIRL", b"First Girl on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731209505134.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGIRL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGIRL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

