module 0x6666b96a08e03c32f1c1473794559eb6149106285443a23f016e7507bb96fdd4::magamas {
    struct MAGAMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGAMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGAMAS>(arg0, 6, b"MAGAMAS", b"CHRISTMAS MAGA", b"Merry Magamas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Salinan_dari_Desain_Tanpa_Judul_9_3ff4d631af.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGAMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGAMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

