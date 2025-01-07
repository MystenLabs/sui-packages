module 0x5db56d4dedfdf9f5b1e7a50102913433b272f2ba3dddf0d8497f771a340f3ad7::sflex {
    struct SFLEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFLEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFLEX>(arg0, 6, b"Sflex", b"Suuflex", b"Not just another streaming platform. We make move's, we make waves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3046_8b3aa3cab8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFLEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFLEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

