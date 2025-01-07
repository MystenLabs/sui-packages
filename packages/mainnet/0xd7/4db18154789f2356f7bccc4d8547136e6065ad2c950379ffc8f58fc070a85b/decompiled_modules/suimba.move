module 0xd74db18154789f2356f7bccc4d8547136e6065ad2c950379ffc8f58fc070a85b::suimba {
    struct SUIMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMBA>(arg0, 6, b"SUIMBA", b"Suimba", x"6c6574732048616b756e61204d61746174610a6f75722077617920746f20746865206d6f6f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000041222_ead64c855a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

