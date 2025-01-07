module 0x980739367982542a71983d84ebc7eeb81cab1733cf6565c1a4fe3259c4bbfd80::cyberpunk {
    struct CYBERPUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBERPUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<CYBERPUNK>(arg0, 6, b"CYBERPUNK", b"Cyber Punk", b"cyber!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shiba_dogs_db3fa014cd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBERPUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<CYBERPUNK>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYBERPUNK>>(v2);
    }

    // decompiled from Move bytecode v6
}

