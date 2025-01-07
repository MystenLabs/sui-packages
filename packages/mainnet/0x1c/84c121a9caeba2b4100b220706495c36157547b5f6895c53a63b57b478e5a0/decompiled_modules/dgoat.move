module 0x1c84c121a9caeba2b4100b220706495c36157547b5f6895c53a63b57b478e5a0::dgoat {
    struct DGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGOAT>(arg0, 6, b"DGoat", b"Downsyndrome Goat", b"Be part of the most retardio $GOAT on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_ohne_Titel_f6439cebc3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

