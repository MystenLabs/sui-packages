module 0x62316f0cbaf4c33cb0470e853288dcff943acedaf90682541c31cc4d22609c1a::dgnbk {
    struct DGNBK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGNBK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGNBK>(arg0, 6, b"DGNBK", b"Degen Bucks", b"Degen Bucks was inspired by a reflection on concepts of time, financial freedom, and the pursuit of happiness. The project features on references from pop culture and was illustrated through the lens of the inner child.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_93b75d6342.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGNBK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGNBK>>(v1);
    }

    // decompiled from Move bytecode v6
}

