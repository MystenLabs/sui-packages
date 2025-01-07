module 0x43b7e952da30786e3229bb739297b5a4899c2bcadb32983e6470451a2b358c97::suiwinn {
    struct SUIWINN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWINN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWINN>(arg0, 6, b"SUIWINN", b"Anita Max Suiwinn", b"Just a water bike. No utility at all. Ape in and come talk shit in the tg.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5260_6bf709eb46.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWINN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWINN>>(v1);
    }

    // decompiled from Move bytecode v6
}

