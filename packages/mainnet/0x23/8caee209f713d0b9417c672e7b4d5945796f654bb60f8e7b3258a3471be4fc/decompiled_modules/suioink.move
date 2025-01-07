module 0x238caee209f713d0b9417c672e7b4d5945796f654bb60f8e7b3258a3471be4fc::suioink {
    struct SUIOINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIOINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIOINK>(arg0, 6, b"SuiOink", b"sui_oink", x"f09f90bdf09fa4bf20244f494e4b20697320746865206d6f737420616476656e7475726f7573207069672c2073637562612d646976696e6720696e746f20535549204f6365616e20f09f92a7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731002325261.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIOINK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIOINK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

