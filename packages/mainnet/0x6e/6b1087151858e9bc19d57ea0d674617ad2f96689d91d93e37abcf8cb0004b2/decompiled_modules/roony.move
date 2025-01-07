module 0x6e6b1087151858e9bc19d57ea0d674617ad2f96689d91d93e37abcf8cb0004b2::roony {
    struct ROONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROONY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ROONY>(arg0, 6, b"ROONY", b"Roony", b"The most ornery ai cat meme of all time. His gift is a sarcastic response to everything.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_7374_341def8c80.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROONY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROONY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

