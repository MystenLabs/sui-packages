module 0x5d1dc0b85ef06fa54a91746368e7a6a7b4cfaba65bd8639ad9bf5e08748da517::plup {
    struct PLUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUP>(arg0, 6, b"PLUP", b"BLUE PIPLUP", b"The most cute water pokemon is now on $SUI $PLUP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3664_65e970eb74.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

