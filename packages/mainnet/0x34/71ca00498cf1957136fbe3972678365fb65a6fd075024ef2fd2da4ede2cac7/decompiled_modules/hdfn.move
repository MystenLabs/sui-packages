module 0x3471ca00498cf1957136fbe3972678365fb65a6fd075024ef2fd2da4ede2cac7::hdfn {
    struct HDFN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDFN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDFN>(arg0, 6, b"HDFN", b"HodlFren", b"Hodl Fren, Hodl Til The End", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1746069485847.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HDFN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDFN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

