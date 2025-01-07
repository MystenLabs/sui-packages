module 0xcf3f8f4c21620f3a114cb98cc93e16391078fd3586a5238f7aaf6b0392dbcb15::magamas {
    struct MAGAMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGAMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGAMAS>(arg0, 6, b"MAGAMAS", b"MERRY MAGAMAS", b"magamas.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Salinan_dari_Desain_Tanpa_Judul_7_208850c381.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGAMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGAMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

