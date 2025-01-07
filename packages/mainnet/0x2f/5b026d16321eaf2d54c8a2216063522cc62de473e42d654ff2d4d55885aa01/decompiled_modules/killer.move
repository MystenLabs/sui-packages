module 0x2f5b026d16321eaf2d54c8a2216063522cc62de473e42d654ff2d4d55885aa01::killer {
    struct KILLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: KILLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KILLER>(arg0, 6, b"Killer", b"solkiller", x"323032352077696c6c206265207468652073756920736561736f6e2e20576520696e766974652065766572796f6e6520746f2074686520737569206e6574776f726b2e2045766572796f6e652c2074616b6520796f757220706c61636520696d6d6564696174656c792e4a5553542042454cc4b0455645", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731519742393.16")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KILLER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KILLER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

