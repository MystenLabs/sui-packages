module 0xa34b86d85b14777b031950243d48fac7c6f2ecdf3b0f10f021ac891d12eec834::crzysui {
    struct CRZYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRZYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRZYSUI>(arg0, 6, b"CRZYSUI", b"crazy sui", b"sui ecosystem meme crazy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022147_96918aee3d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRZYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRZYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

