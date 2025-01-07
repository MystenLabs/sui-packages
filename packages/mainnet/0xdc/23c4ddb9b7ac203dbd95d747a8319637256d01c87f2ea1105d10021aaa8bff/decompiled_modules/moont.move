module 0xdc23c4ddb9b7ac203dbd95d747a8319637256d01c87f2ea1105d10021aaa8bff::moont {
    struct MOONT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONT>(arg0, 1, b"MOONt", b"MOONticket", b"Ultra limited chance for space travel ticket.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOONT>(&mut v2, 100000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONT>>(v1);
    }

    // decompiled from Move bytecode v6
}

