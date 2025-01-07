module 0x6bca2b2568fb8ec693ea320968d8bc430e1165490ee1f3adae82f2ad3c04ac9d::furry {
    struct FURRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FURRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FURRY>(arg0, 6, b"FURRY", b"FURRY SOLDIERS", b"After years we decided to take over. No more dry food! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000860_a3d20b335d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FURRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FURRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

