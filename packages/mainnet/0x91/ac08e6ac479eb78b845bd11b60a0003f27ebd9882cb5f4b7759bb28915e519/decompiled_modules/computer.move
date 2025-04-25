module 0x91ac08e6ac479eb78b845bd11b60a0003f27ebd9882cb5f4b7759bb28915e519::computer {
    struct COMPUTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMPUTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMPUTER>(arg0, 6, b"COMPUTER", b"computer sui", b"Welcome to the next generation of meme coins ,the biggest coin on the net Sui for those who believe that the most volatile thing in the market is the habit of observing computers and the market in an intelligent way", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/54b6d39f_4aea_445e_a789_5f954e376512_bca4d2e1a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMPUTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COMPUTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

