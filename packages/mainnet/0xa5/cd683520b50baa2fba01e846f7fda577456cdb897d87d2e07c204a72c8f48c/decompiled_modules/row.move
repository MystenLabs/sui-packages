module 0xa5cd683520b50baa2fba01e846f7fda577456cdb897d87d2e07c204a72c8f48c::row {
    struct ROW has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ROW>(arg0, 6, b"ROW", b"Row by SuiAI", b"Row Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/90412504_51ce24d555.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROW>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROW>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

