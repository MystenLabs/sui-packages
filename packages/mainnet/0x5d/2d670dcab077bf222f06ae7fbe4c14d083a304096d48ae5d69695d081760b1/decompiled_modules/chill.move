module 0x5d2d670dcab077bf222f06ae7fbe4c14d083a304096d48ae5d69695d081760b1::chill {
    struct CHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHILL>(arg0, 6, b"CHILL", b"Chillphin by SuiAI", x"4348494c4c5048494e2069732074686520736d61727465737420616e64206d6f7374206c6569737572652d6c6f76696e6720706574206f66205375692e20576974682074686520696e74656c6c6967656e6365206f66206120646f6c7068696e2c2068652068617320746865206162696c69747920746f2073757266206f6e2074686520776176657320696e207468652067726170682e20f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000437183_39844fec75.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHILL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

