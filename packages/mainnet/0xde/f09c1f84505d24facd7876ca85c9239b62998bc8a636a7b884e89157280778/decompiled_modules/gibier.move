module 0xdef09c1f84505d24facd7876ca85c9239b62998bc8a636a7b884e89157280778::gibier {
    struct GIBIER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIBIER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIBIER>(arg0, 9, b"Gibier", b"Gibier&Sons", x"4c65206d696d20636f696e20c3a0206c61206d6f646520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ad8ceffb8df325495b67ef6140d1b462blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIBIER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIBIER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

