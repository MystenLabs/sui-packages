module 0x7dbbf00ce2e7f1134e2ae083daee5794a85682cfc65cdbe58edff0a521c97853::funny2 {
    struct FUNNY2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNNY2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNNY2>(arg0, 6, b"FUNNY2", b"Funny 2", b"SHOWTIME!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731020090016.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUNNY2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNNY2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

