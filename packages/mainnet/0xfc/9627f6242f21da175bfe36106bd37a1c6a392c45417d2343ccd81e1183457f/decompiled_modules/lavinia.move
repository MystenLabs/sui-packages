module 0xfc9627f6242f21da175bfe36106bd37a1c6a392c45417d2343ccd81e1183457f::lavinia {
    struct LAVINIA has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LAVINIA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LAVINIA>>(0x2::coin::mint<LAVINIA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LAVINIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAVINIA>(arg0, 9, b"LAV", b"Lavinia", b"Official Lavinia Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lh3.googleusercontent.com/d/1Rm1Hh5FTvcBeKq0wVqt4ZZ3v1jWieDQ")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAVINIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAVINIA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

