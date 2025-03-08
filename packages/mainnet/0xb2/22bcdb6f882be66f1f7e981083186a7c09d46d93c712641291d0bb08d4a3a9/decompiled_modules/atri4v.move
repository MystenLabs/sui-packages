module 0xb222bcdb6f882be66f1f7e981083186a7c09d46d93c712641291d0bb08d4a3a9::atri4v {
    struct ATRI4V has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATRI4V, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATRI4V>(arg0, 6, b"ATRI4V", b"atri4v", b"@ atri4v Introduce SUI dividends", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000032243_51808147cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATRI4V>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATRI4V>>(v1);
    }

    // decompiled from Move bytecode v6
}

