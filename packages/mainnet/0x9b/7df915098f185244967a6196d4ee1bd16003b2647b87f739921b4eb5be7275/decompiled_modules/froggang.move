module 0x9b7df915098f185244967a6196d4ee1bd16003b2647b87f739921b4eb5be7275::froggang {
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

