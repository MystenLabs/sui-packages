module 0xbdcc1eee69d9283290b637d4b4beaacc28df7e754461e6a59641fbd0236ab3b8::pnut {
    struct PNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUT>(arg0, 6, b"PNUT", b"PNUT ON SUI ", x"48656c6c6f2c204920616d20504e5554200a496620796f7520737472696b65206d6520646f776e2c206d79206d61726b6574206361702077696c6c206265636f6d65206d6f726520706f77657266756c207468616e20796f7520636f756c6420706f737369626c7920696d6167696e652e20f09f90bfefb88f20f09f90bfefb88f20f09f90bfefb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953651938.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

