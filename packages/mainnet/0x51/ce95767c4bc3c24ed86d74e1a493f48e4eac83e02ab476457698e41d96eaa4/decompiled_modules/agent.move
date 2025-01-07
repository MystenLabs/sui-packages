module 0x51ce95767c4bc3c24ed86d74e1a493f48e4eac83e02ab476457698e41d96eaa4::agent {
    struct AGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENT>(arg0, 6, b"AGENT", b"MatrixOracle", x"4d6174726978204f7261636c6520697320746865206669727374204149206167656e74206f6e20535549207468617420637261667473206e6577206e6172726174697665732c2064726976656e20627920796f757220656e676167656d656e742e0a0a49742061646170747320616e642065766f6c76657320696e207265616c2074696d652c206f66666572696e67206120706572736f6e616c697a65642c20696d6d6572736976652073746f727974656c6c696e6720657870657269656e63652074686174207075747320796f75206174207468652063656e746572206f662074686520706c6f742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734976279594.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

