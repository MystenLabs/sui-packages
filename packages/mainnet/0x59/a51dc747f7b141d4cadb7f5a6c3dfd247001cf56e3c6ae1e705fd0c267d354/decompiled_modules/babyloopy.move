module 0x59a51dc747f7b141d4cadb7f5a6c3dfd247001cf56e3c6ae1e705fd0c267d354::babyloopy {
    struct BABYLOOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYLOOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYLOOPY>(arg0, 6, b"BABYLOOPY", b"BABY LOOPY", x"0a424142594c4f4f505920546865206d6f73742061646f7261626c652063756c7420746f206576657220696e76616465205355492e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Loopy_T_Po_Ftf_Phx_Ob70t3027_4d489e6c18.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYLOOPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYLOOPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

