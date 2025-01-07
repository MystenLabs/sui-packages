module 0x8b31cb30893c9ace57204bb53e56685c6053b5d60b95c66154b97708d8a0584e::cmnt {
    struct CMNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMNT>(arg0, 6, b"CMNT", b"Community", b"a meme coin for all humanity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735082109666.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CMNT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMNT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

