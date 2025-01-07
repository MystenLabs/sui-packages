module 0x11b559b4f5ca46c7da459d0b47fe91f1ca6a03212895a740a6461e1045fcab9d::flokiblue {
    struct FLOKIBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOKIBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKIBLUE>(arg0, 6, b"FlokiBlue", b"FLOKIBLUE", x"466c6f6b69206f6e207375692c2049276d20666c6f6b6920626c75652e200a24466c6f6b69426c75652c206375746520616e6420616c6c20626c75652c20477569646520796f757220616476656e74757265206f6e20235375692e200a4c696b652023466c6f6b69207468652056696b696e672c200a6865206e617669676174657320746f206e657720686f72697a6f6e73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GIFFLOKIBLUE_d3c08366b1.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKIBLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOKIBLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

