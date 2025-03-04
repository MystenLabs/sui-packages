module 0x13119bac132b8a9d365480fe496e5ab8b1bcd2972181a2524e09dc66db99f0dd::suits {
    struct SUITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"F3Ez-b6RA8ka7z6T                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SUITS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SUITS       ")))), trim_right(b"TRUMP NEW LAW (LEGAL)           "), trim_right(x"4e6577204c6177205265717569726573204445582053637265656e657220557365727320746f2057656172205375697473205768696c652054726164696e670d0a0d0a496e206120626f6c64206d6f766520746f20726573746f7265206465636f72756d20616e642070726f66657373696f6e616c69736d20696e207468652063727970746f63757272656e63792073706163652c20507265736964656e74205472756d702068617320656e61637465642061206e6577206c6177206d616e646174696e67207468617420616c6c207573657273206f66204445582053637265656e6572206d757374207765617220666f726d616c20627573696e65737320617474697265207768696c6520656e676167696e6720696e20646563656e7472616c697a65642065786368616e67652074726164696e672e0d0a0d0a436974696e"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITS>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

