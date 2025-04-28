module 0xd19a818d0dfc5861aba1d2d95725ec030dd4f1f8b88fe23fe89e2654d8ab1618::helpthem {
    struct HELPTHEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELPTHEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELPTHEM>(arg0, 9, b"HELPTHEM", b"HELP", b"Ayo selamatkan diri kamu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/889883db9570380fb28f032d2033d7a6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELPTHEM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELPTHEM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

