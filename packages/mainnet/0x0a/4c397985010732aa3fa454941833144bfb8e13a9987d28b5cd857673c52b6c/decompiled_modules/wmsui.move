module 0xa4c397985010732aa3fa454941833144bfb8e13a9987d28b5cd857673c52b6c::wmsui {
    struct WMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WMSUI>(arg0, 6, b"WMSUI", b"Waterman ", b"Waterman, the SUIperhero. Be water MF - https://t.me/waterman_SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730959016665.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WMSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WMSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

