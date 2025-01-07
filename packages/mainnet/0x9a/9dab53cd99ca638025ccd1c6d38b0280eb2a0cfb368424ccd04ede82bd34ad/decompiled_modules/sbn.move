module 0x9a9dab53cd99ca638025ccd1c6d38b0280eb2a0cfb368424ccd04ede82bd34ad::sbn {
    struct SBN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBN>(arg0, 6, b"SBN", b"SuiBONO", x"5377696d6d696e6720696e2053756920746f20746865206d6f6f6e0a546f20746865206d6f6f6e20616e64206265796f6e6420", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734326746531.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

