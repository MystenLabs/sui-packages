module 0x4f2cb52aaa341ef445d36e2fd27a15c4882e5ededdb718fa2bbb4341d5ab1a02::smid {
    struct SMID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMID>(arg0, 6, b"SMID", b"SUIMID", x"596f75722066696e616c206368616e6365206e6f7420746f206d69642063757276652069740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kay_Rp_T4l_400x400_12427e815b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMID>>(v1);
    }

    // decompiled from Move bytecode v6
}

