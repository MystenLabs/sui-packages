module 0x7fca14bde25c31ebffabcb48d7c2dedf07bb0eaa4823e7255ece67fb15a717db::cepy {
    struct CEPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEPY>(arg0, 6, b"CEPY", b"CEPYBALA", b"We are the next meme coin on sui !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241011_235327_a4b90fb531.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CEPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

