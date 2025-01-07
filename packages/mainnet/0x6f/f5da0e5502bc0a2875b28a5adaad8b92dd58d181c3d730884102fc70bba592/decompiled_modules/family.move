module 0x6ff5da0e5502bc0a2875b28a5adaad8b92dd58d181c3d730884102fc70bba592::family {
    struct FAMILY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAMILY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAMILY>(arg0, 6, b"FAMILY", b"Family SUI", x"57656c636f6d6520746f20746865206d6f7374206368616f7469632063727970746f2066616d696c7920696e207468652067616d652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/family_d719cc7413.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAMILY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAMILY>>(v1);
    }

    // decompiled from Move bytecode v6
}

