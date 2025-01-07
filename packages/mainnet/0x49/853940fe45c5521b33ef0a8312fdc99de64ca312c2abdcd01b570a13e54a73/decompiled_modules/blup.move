module 0x49853940fe45c5521b33ef0a8312fdc99de64ca312c2abdcd01b570a13e54a73::blup {
    struct BLUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUP>(arg0, 9, b"BLUP", b"BLUP", b"herald of despair", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUP>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

