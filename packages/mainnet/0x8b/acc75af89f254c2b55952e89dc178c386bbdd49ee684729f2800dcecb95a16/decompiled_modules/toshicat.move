module 0x8bacc75af89f254c2b55952e89dc178c386bbdd49ee684729f2800dcecb95a16::toshicat {
    struct TOSHICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOSHICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOSHICAT>(arg0, 6, b"TOSHICAT", b"TOSHI CAT ON SUI", b"$TOSHI CAT is the 1st multi utility + meme project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unnamed_fda9b7c36b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOSHICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOSHICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

