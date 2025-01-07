module 0x71290496cc07c09199190b7b3a267a5487e3c25ac78d69b979edc366e14f4787::bullc {
    struct BULLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLC>(arg0, 6, b"BULLC", b"BULLCEMBER", b"IT IS TIME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241129_052907_086_3e086e89b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLC>>(v1);
    }

    // decompiled from Move bytecode v6
}

