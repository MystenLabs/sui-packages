module 0xd92fd469f4d7eafbd6095b97ff548cad7a85dc35e2e570bb3ef4d4e3712900a::cell {
    struct CELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CELL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CELL>(arg0, 6, b"CELL", b"Cell Dragon Ball", x"43656c6c2028e382bbe383ab2c20536572752c58c3aa6e2042e1bb8d2048756e6729206cc3a0206de1bb99742074726f6e67206e68e1bbaf6e67206e67c6b0e1bb9d69206dc3a179207369c3aa752068e1baa16e6720646f205469e1babf6e2073c4a9204765726f2073c3a16e672074e1baa16f2c206368e1bba9612074e1baa5742063e1baa32063c3a163206b68e1baa3206ec4836e672063e1bba7612063c3a16320636869e1babf6e2062696e68206de1baa16e68206e68e1baa5742074e1bbab6e67207875e1baa574206869e1bb876e2074e1baa169205472c3a16920c490e1baa574206e68c6b020536f6e20476f6b752c205665676574612c204b696e6720436f6c642c20467269657a612c20506963636f6c6f2ce280a6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.daosui.fun/uploads/cell_e69fe33c37.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CELL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CELL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

