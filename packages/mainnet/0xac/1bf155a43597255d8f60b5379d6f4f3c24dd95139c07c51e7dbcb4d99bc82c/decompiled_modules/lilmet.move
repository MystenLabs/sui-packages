module 0xac1bf155a43597255d8f60b5379d6f4f3c24dd95139c07c51e7dbcb4d99bc82c::lilmet {
    struct LILMET has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILMET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILMET>(arg0, 6, b"LILMET", b"Meteora Mascot MET", b"LIL MET is the name given to Meteora's Mascot by the co founder ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LILMET_TJKC_Um_avhes_Oc7ko_LE_be2bcca0db.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILMET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LILMET>>(v1);
    }

    // decompiled from Move bytecode v6
}

