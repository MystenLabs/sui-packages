module 0x7e6c6f2a6295e9cc0dc6c2cf695f56a8be87a6392503831cb53d22a07c910bd8::pony {
    struct PONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONY>(arg0, 6, b"PONY", b"Prison Pony", x"4d65657420507269736f6e20506f6e7920546f6b656e206f6e2053554920436861696e2120f09fa6932054686520636f6f6c657374207374726970657320696e2063727970746f2c206272696e67696e672066756e2c207574696c6974792c20616e6420612064617368206f66207a6562726120666c6169722e205768657468657220697427732072756e6e696e67206f722064616e63696e67207468726f7567682074686520626c6f636b636861696e2c207468697320746f6b656e206973206865726520746f206d616b6520796f75722077616c6c657420726f61722077697468206a6f792120f09f9a80f09f8e89", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732537931782.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PONY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

