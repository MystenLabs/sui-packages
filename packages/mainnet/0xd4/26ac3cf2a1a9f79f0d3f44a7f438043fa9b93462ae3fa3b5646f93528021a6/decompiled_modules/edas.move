module 0xd426ac3cf2a1a9f79f0d3f44a7f438043fa9b93462ae3fa3b5646f93528021a6::edas {
    struct EDAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDAS>(arg0, 6, b"EDAS", b"terawe", b"tae", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731967128843.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EDAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

