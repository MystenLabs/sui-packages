module 0x8cb5d032f3776c68a27efaee5f7dbf0a3def9b0a36940b137d8acadb7bc6b50b::catfish {
    struct CATFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATFISH>(arg0, 6, b"CATFISH", b"CAT FISH on SUI", x"466973682063617420796f75207365650a796f7520646f6e27742062656c696576650a616e6420796f752063616e277420756e736565206974", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731505029576.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATFISH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATFISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

