module 0x15826c2e34c2760db95e08e781372a51b0a39e4fe3f4727659a2f68c4441d35b::suipi {
    struct SUIPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPI>(arg0, 6, b"SUIPI", b"PINGUIN MASCOT SUI", b"$SUIPI embark on an icy adventure like no other tands as a distinctive meme token on Sui, boasting a cutest and charming penguin mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3662_4e042f2098.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

