module 0xa28d1014abb36dc074ecadf0c6d5b84866df2481f65c76bb0a073c0ceb20058b::blsh {
    struct BLSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLSH>(arg0, 6, b"BLSH", b"Buy Low Sell High", x"4f6e6c79206f6e652072756c65206170706c69657320686572653a0a427579204c6f772c2053656c6c20486967680a0a496620796f752068617665206e6f74206c6561726e656420746f206c69766520627920746869732072756c652c207468616e20796f75206d617920626520696e207468652077726f6e672073706163652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BLSH_zoom_2a9a679629.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

