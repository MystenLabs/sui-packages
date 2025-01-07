module 0x20143be40dffd9bcd871669886edd3bcaa081001079bbb0311073f27a2df2ed7::koban {
    struct KOBAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOBAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOBAN>(arg0, 6, b"KOBAN", b"MANEKINEKO", b"MANEKINEKO have her crypto asset called $KOBAN on SUI network. Now open for buy and sell. This is a tribute to the fantastic and magical lucky cat. Legend has it that with his right paw raise", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730588141338.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOBAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOBAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

