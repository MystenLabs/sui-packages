module 0xb2422dd63a8996d06d9e28e55f72ddb5e91ec593b030fdb0af0cfb8b8a3ad0a7::peblo {
    struct PEBLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEBLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEBLO>(arg0, 6, b"PEBLO", b"Sui Peblo", b"Peblo - He wasnt just family; Peblo was the one who made things happen, a figure of influence that Pepe and his friends could always rely on when they needed things to move", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013985_11fec55158.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEBLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEBLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

