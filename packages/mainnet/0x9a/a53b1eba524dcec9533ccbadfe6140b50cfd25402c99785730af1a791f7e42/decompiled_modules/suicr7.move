module 0x9aa53b1eba524dcec9533ccbadfe6140b50cfd25402c99785730af1a791f7e42::suicr7 {
    struct SUICR7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICR7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICR7>(arg0, 6, b"SuiCR7", b"CR7", b"Welcome to the \"Cristiano Ronaldo Fans Token\" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733932415871.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICR7>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICR7>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

