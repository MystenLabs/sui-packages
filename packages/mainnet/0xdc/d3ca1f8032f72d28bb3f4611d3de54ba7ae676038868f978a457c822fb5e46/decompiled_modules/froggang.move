module 0xdcd3ca1f8032f72d28bb3f4611d3de54ba7ae676038868f978a457c822fb5e46::froggang {
    struct FROGGANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGANG>(arg0, 6, b"Froggang", b"Frog gang", b"\" fROG gANG tAKIN' oVER tHE bLOCKCHAIN!  hOP iN, sWIPE cOINS, aND mAKE sPLASHES!  #fROGgANG #sUIpOWER #cRYPTOkINGS\" #Gang Gang. Heading to the  moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016802_833871412a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGGANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

