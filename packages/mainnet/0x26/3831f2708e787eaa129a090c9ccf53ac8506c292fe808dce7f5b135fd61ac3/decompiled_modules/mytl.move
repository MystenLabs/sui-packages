module 0x263831f2708e787eaa129a090c9ccf53ac8506c292fe808dce7f5b135fd61ac3::mytl {
    struct MYTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYTL>(arg0, 6, b"MYTL", b"Mysten Lab", b"REDACTED ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1791190142243.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYTL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYTL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

