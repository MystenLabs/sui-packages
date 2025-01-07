module 0xdd72d0832940ed549ad40e1dcf73b47cdbcde90930085333cae58587f78ce18f::foxo {
    struct FOXO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOXO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOXO>(arg0, 6, b"Foxo", b"Foox", b"The red fox is an integral part of the Sui ecosystem. The same corner that will become its emblem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4150_2b3361325e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOXO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOXO>>(v1);
    }

    // decompiled from Move bytecode v6
}

