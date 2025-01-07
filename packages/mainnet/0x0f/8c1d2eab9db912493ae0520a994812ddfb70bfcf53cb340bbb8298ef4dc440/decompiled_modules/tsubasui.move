module 0xf8c1d2eab9db912493ae0520a994812ddfb70bfcf53cb340bbb8298ef4dc440::tsubasui {
    struct TSUBASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUBASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUBASUI>(arg0, 6, b"TSUBASUI", b"TSUBASA on SUI", b"The first meme token inspired by Captain Tsubasa. Ball is our friend. Football Manga #CaptainTsubasa is coming to SUI Blockchain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731211428320.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSUBASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUBASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

