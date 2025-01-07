module 0x5eb9e049a23cb83383f9052a9942280eb79d0f5f6e05646a9f19bb904ce2c18b::ceocat {
    struct CEOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEOCAT>(arg0, 6, b"CEOCAT", b"CeoCat", b"CeoCat a new token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_29_at_17_04_17_9780d5e1ad.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CEOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

