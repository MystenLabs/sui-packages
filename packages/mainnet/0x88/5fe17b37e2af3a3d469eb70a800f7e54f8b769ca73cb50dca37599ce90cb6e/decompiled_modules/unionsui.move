module 0x885fe17b37e2af3a3d469eb70a800f7e54f8b769ca73cb50dca37599ce90cb6e::unionsui {
    struct UNIONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNIONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIONSUI>(arg0, 6, b"UNIONSUI", b"SUI UNI", x"0a6661766f75726974652070657420646f6720756e692042657374206d656d65206f6e205375692d636861696e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/E_Fl5_X_h_R_400x400_bddd344bd1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNIONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNIONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

