module 0xa1abd812067b1a8cbc59963b28790ac943a5748e482ce564b61818ffe9640b1c::nub {
    struct NUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUB>(arg0, 6, b"NUB", b"NubCat", b"nub is a silly cat for the silliest of goobers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6762_62ff13c5b8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

