module 0xe09870e519d6f349bc6cf9d02eb69e999b7479a0dde564965fa99d4625888d65::et {
    struct ET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ET>(arg0, 6, b"ET", b"ElonTrump", b"Elon Musk and Trump will make America Great again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trump_d4e801075f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ET>>(v1);
    }

    // decompiled from Move bytecode v6
}

