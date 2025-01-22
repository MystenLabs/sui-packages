module 0x9637980b338d8c46080bf8705c35af5781b1af8389be2698fa4cce8b87f889d::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP>(arg0, 6, b"PUMP", b"Donald Pump", b"Mr President Pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/donald_pump_5ea7567564.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

