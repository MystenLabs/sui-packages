module 0x1ec3f58b8018452bca06d7cfe5725454f7eeec0f6fcf89ea012cdb08819606ff::drsui {
    struct DRSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRSUI>(arg0, 6, b"DRSUI", b"Doctor SUI", x"466f722074686520646f63746f72206f6e6c790a47657420796f75722073746574686f73636f706520616e64206578616d696e6520796f75722063686573740a5468697320636f696e2077696c6c206d616b6520796f757220636172646961632070616c706174696e6720", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046166_8de8d6218c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

