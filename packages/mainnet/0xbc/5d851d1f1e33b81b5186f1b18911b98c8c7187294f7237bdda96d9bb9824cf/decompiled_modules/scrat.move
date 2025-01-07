module 0xbc5d851d1f1e33b81b5186f1b18911b98c8c7187294f7237bdda96d9bb9824cf::scrat {
    struct SCRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCRAT>(arg0, 6, b"Scrat", b"scrat", b"scratch on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qqv0n_E5j_400x400_572e9325c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCRAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCRAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

