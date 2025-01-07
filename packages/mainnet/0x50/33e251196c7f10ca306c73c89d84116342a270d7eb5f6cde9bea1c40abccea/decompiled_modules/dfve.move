module 0x5033e251196c7f10ca306c73c89d84116342a270d7eb5f6cde9bea1c40abccea::dfve {
    struct DFVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFVE>(arg0, 6, b"DFVE", b"DeFiVeRsE", x"22f09f8c90204469766520696e746f2074686520776f726c64206f66202a2a4465466956657273652a2a2120f09f9a80204d696e7420796f7572206578636c7573697665202a2a4e465f4554732a2a206e6f7720616e642073656375726520796f75722073706f7420696e2074686520667574757265206f6620646563656e7472616c697a65642066696e616e6365212057697468206f6e6c79202a2a342c303030204e465f4554732a2a20617661696c61626c652c20746865736520746f6b656e732061726520646973617070656172696e6720666173746572207468616e2055464f207369676874696e677320f09f91bd2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730964658108.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

