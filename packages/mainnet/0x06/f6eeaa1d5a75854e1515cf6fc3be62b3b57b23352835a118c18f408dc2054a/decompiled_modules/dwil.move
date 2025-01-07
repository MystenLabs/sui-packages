module 0x6f6eeaa1d5a75854e1515cf6fc3be62b3b57b23352835a118c18f408dc2054a::dwil {
    struct DWIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWIL>(arg0, 6, b"DWil", b"pupwiLam", b"Loading", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3478_1e36b6cc59.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

