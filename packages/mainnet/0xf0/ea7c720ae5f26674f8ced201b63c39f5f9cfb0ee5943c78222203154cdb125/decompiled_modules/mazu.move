module 0xf0ea7c720ae5f26674f8ced201b63c39f5f9cfb0ee5943c78222203154cdb125::mazu {
    struct MAZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAZU>(arg0, 6, b"MAZU", b"MazuFinance", x"53696d706c696679696e67205969656c64204661726d696e6720696e20746865205355492045636f73797374656d204d617a752077696c6c20677569646520796f75207468726f75676820746865205375696e616d69210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Lx_tv_G_Lo_400x400_92cd9e49be_b7972b90ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAZU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAZU>>(v1);
    }

    // decompiled from Move bytecode v6
}

