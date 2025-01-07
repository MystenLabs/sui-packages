module 0x545204b4245d8ed8040fa6af0c462790bf6327a630eb92945b577f7caf8b5a15::dododo {
    struct DODODO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DODODO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DODODO>(arg0, 9, b"DODODO", x"f09fa6884261627920536861726b", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DODODO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DODODO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DODODO>>(v1);
    }

    // decompiled from Move bytecode v6
}

