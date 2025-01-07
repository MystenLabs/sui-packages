module 0xcdad192a27d87e3bda78ab450378723adaca9922d6f19b4b8677f8c966197e78::bcci {
    struct BCCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCCI>(arg0, 6, b"BCCI", b"bcci", b"Official Board of Control for Cricket in India", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731678628397.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BCCI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCCI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

