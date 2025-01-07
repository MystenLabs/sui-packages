module 0x89ab464603feaf3aa423959be5e83896156ba26c7aa0b4bb98649391250fc045::suinny {
    struct SUINNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINNY>(arg0, 6, b"SUINNY", b"SUINNI", b"Meet Suinny, the laziest, most laid-back character on sui. Yawn will bring financial freedom for every holders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_d05299c751.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

