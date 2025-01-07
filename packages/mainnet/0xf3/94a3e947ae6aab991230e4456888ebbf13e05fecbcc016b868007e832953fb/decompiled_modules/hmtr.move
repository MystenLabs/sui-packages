module 0xf394a3e947ae6aab991230e4456888ebbf13e05fecbcc016b868007e832953fb::hmtr {
    struct HMTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMTR>(arg0, 6, b"Hmtr", b"SuiHamster", b"Only Hamster Lovers here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731077415918.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HMTR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMTR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

