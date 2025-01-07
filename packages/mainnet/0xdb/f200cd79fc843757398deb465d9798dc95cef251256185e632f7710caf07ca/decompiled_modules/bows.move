module 0xdbf200cd79fc843757398deb465d9798dc95cef251256185e632f7710caf07ca::bows {
    struct BOWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOWS>(arg0, 6, b"BOWS", b"Book of Wall Street Sui", b"This token is all about mastering the art of trading, making big moves, and writing your own success story in the crypto markets", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/book_of_wall_st2_1536x1536_f0a831ca5e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

