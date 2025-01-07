module 0x563f5e7754663ff9fceb380d37ac53191b068c56e6e5ce62c5b4226ab1434874::popcat {
    struct POPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPCAT>(arg0, 6, b"POPCAT", b"aaa POPCAT", x"6161612063616e27742073746f7020776f6e27742073746f70207468696e6b696e672061626f75742024504f50434154206161610a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MICKY_3_6530bc1b40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

