module 0x92b12c5676e6852c5cf69986c3fc56cc300df1ba9c988df90dd37bbdf8f011a4::bom {
    struct BOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOM>(arg0, 6, b"BOM", b"Book of Matt Furie", b"Hold on tight, folks! The Book of Matt Furie is about to hit MovePump.com, and its gonna be wild! Get ready for some Pepe-level fun, but this time, its all about rare NFTs and big gains. Im in early, and you better believe Im not missing out. This aint your average meme coin its the real deal. Get ready to ape in!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_22_07_15_3073d6ed61.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

