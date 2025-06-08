module 0x98cfc1914e2877f9e0f9b2a6bf4fc4851986a5a01e25b8c5f7c651072905ba57::pege {
    struct PEGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEGE>(arg0, 6, b"PEGE", b"Pege Coin", b"PEGE is constantly torn between two personas the chill and positive Doge and the sad existential Pepe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifx23c3yxmmlnhpc3utpfiol5u4lwxv6csu2ki25mi6myirohsle4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

