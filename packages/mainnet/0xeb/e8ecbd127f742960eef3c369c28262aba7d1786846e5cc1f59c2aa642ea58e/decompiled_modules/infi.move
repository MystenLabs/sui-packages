module 0xebe8ecbd127f742960eef3c369c28262aba7d1786846e5cc1f59c2aa642ea58e::infi {
    struct INFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: INFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INFI>(arg0, 6, b"INFI", b"Infinia AI", x"4578706c6f726520496e66696e69746520506f73736962696c6974696573207769746820496e66696e69612041492e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736439428561.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INFI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

