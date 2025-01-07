module 0x3975fa16ae5549dc7c056bda412d01d7e1134c5e447aa1c53c7b294ca909b960::dfun {
    struct DFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFUN>(arg0, 9, b"DFUN", b"defun", x"e8bf99e698af376b66756ee4b88ae99da2e594afe4b880e4b880e4b8aae5ae98e696b9e4bba3e5b881", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/37f2585937661da55fb243627a9ccbf3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

