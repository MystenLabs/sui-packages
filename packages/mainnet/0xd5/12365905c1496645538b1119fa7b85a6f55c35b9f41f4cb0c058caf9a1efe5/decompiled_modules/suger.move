module 0xd512365905c1496645538b1119fa7b85a6f55c35b9f41f4cb0c058caf9a1efe5::suger {
    struct SUGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGER>(arg0, 6, b"SUGER", b"Glucose", b"Life needs energy, your portfolio needs $SUGAR.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735519862745.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUGER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

