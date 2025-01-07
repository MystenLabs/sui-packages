module 0x50d4e0ae32411f8153353ad170bb3852f80ea852ab16d2b92d383fbc14cdc6df::fatg {
    struct FATG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATG>(arg0, 6, b"FATG", b"Fat Guy", b"          , ,             . \"   \"                      ,   ,           .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3232_1_6fef494f5b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FATG>>(v1);
    }

    // decompiled from Move bytecode v6
}

