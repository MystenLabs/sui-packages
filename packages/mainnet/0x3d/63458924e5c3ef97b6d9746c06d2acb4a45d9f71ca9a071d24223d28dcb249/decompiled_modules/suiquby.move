module 0x3d63458924e5c3ef97b6d9746c06d2acb4a45d9f71ca9a071d24223d28dcb249::suiquby {
    struct SUIQUBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIQUBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIQUBY>(arg0, 6, b"SUIQUBY", b"SQUBY", b"A new hero has emerged, bearing the name \"Quby\". This token is not just any ordinary cryptocurrency, for it honors one of the most revered and beloved characters of Chinese legendry - a creature both cute and powerful, known for its ability to bring good fortune to all who lay eyes upon it. Quby's emergence is nothing short of magical, Quby is poised to capture the hearts and minds of all who seek prosperity and fortune in the digital age.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_4e17831d21.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIQUBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIQUBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

