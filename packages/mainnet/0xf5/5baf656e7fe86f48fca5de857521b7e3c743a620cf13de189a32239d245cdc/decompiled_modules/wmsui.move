module 0xf55baf656e7fe86f48fca5de857521b7e3c743a620cf13de189a32239d245cdc::wmsui {
    struct WMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WMSUI>(arg0, 6, b"WMSUI", b"Waterman", b"Waterman, the SUIperhero. Be water MF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731005440466.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WMSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WMSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

