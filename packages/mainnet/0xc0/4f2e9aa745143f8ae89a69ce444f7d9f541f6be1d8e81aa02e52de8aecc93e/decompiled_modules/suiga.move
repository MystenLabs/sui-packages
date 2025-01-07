module 0xc04f2e9aa745143f8ae89a69ce444f7d9f541f6be1d8e81aa02e52de8aecc93e::suiga {
    struct SUIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGA>(arg0, 6, b"SUIGA", b"SUIGATOR", b" cutest alligator on the SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956579626.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

