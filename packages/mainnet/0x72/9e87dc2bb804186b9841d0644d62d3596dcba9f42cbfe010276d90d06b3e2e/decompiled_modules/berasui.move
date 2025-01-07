module 0x729e87dc2bb804186b9841d0644d62d3596dcba9f42cbfe010276d90d06b3e2e::berasui {
    struct BERASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERASUI>(arg0, 9, b"BERASUI", b"Bera on SUI", b"a Bera on Sui. not less not more", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8d0fe026ef5f587c57efe40dce0b2462blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BERASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

