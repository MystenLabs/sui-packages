module 0x18c5262398fe30cf846d943d93bbc8792ffea53b2c261893eafee2b86f20d8a7::amc {
    struct AMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMC>(arg0, 6, b"AMC", b"AMC SUI", b"Apes are not giving a shit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/store_icon_d51a03946b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

