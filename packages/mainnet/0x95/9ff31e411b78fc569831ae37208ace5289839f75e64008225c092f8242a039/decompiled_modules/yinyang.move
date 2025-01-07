module 0x959ff31e411b78fc569831ae37208ace5289839f75e64008225c092f8242a039::yinyang {
    struct YINYANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: YINYANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YINYANG>(arg0, 6, b"YINYANG", b"Yin and Yang", b"A token of fire and water", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731452432749.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YINYANG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YINYANG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

