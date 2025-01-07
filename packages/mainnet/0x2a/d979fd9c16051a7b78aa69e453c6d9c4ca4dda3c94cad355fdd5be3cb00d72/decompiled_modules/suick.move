module 0x2ad979fd9c16051a7b78aa69e453c6d9c4ca4dda3c94cad355fdd5be3cb00d72::suick {
    struct SUICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICK>(arg0, 6, b"SUICK", b"SUI SICK", b"sick for sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731012269272.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

