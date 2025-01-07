module 0x65ecf35f6513daff5a04d15def102e7ee517069abb3527a2cde703ba1c39aa3::pepuardo {
    struct PEPUARDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPUARDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPUARDO>(arg0, 6, b"PEPUARDO", b"PEPUARDO TACOS", x"53692e2e2e49206c696b65207461636f732e200a4d65206775737461206275727269746f732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733340575405.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPUARDO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPUARDO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

