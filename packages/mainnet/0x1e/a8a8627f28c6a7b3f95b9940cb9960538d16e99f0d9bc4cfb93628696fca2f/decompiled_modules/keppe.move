module 0x1ea8a8627f28c6a7b3f95b9940cb9960538d16e99f0d9bc4cfb93628696fca2f::keppe {
    struct KEPPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEPPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEPPE>(arg0, 6, b"Keppe", b"KEPPE", b"KEPPE is a token where Kappa disguises itself as Pepe, showcasing a distinctive characteristic as a symbol of humor and community spirit in Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241007_222350_204_4d31022e81.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEPPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEPPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

