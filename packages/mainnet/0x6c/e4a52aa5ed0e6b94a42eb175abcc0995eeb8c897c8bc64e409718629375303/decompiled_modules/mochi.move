module 0x6ce4a52aa5ed0e6b94a42eb175abcc0995eeb8c897c8bc64e409718629375303::mochi {
    struct MOCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCHI>(arg0, 6, b"MOCHI", b"Mochi Got Bored", x"496e737069726564206279207468652061646f7261626c6520616e64206c617a79204d6f6368696520746865206361742c2077652063726561746564207468697320636f696e20746f2072656d696e642065766572796f6e6520746861742077652063616e20676f2066726f6d206c617a7920746f2070726f647563746976650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_Qc_Z1zt4_400x400_d03f58b8da.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

