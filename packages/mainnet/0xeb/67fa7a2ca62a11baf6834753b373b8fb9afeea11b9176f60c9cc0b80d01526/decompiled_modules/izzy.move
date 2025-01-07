module 0xeb67fa7a2ca62a11baf6834753b373b8fb9afeea11b9176f60c9cc0b80d01526::izzy {
    struct IZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IZZY>(arg0, 6, b"IZZY", b"Izzy - Matt Furie's Dog", b"Izzy, the Golden Retriever of Matt Furie, creator of Pepe! Build on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/izzy_logo_e814a022b8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

