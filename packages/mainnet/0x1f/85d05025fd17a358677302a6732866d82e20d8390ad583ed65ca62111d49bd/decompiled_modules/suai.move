module 0x1f85d05025fd17a358677302a6732866d82e20d8390ad583ed65ca62111d49bd::suai {
    struct SUAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUAI>(arg0, 6, b"SUAI", b"AImerica", b"The First AI Country", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/almerica_d9f13103ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

