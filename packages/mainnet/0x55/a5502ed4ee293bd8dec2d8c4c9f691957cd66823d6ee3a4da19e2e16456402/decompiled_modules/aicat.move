module 0x55a5502ed4ee293bd8dec2d8c4c9f691957cd66823d6ee3a4da19e2e16456402::aicat {
    struct AICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AICAT>(arg0, 6, b"AICAT", b"AICAT ON SUI", x"54473a2068747470733a2f2f742e6d652f6169636174636f696e7375690a547769747465723a2068747470733a2f2f782e636f6d2f4149434154434f494e5355490a54696b746f6b3a2068747470733a2f2f742e636f2f5a6e44436b3832487263", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_aicat_5d12ce881c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

