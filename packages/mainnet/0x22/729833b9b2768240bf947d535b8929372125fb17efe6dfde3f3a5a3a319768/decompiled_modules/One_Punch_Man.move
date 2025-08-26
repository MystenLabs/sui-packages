module 0x22729833b9b2768240bf947d535b8929372125fb17efe6dfde3f3a5a3a319768::One_Punch_Man {
    struct ONE_PUNCH_MAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONE_PUNCH_MAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONE_PUNCH_MAN>(arg0, 9, b"OPM", b"One Punch Man", b"one punch mfer. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9090/kit/TemporaryCoinAvatar/01K3KNT4XHF7NNDEC363E0NH00.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONE_PUNCH_MAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONE_PUNCH_MAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

