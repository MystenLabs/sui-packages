module 0x6706c052613d62dc3bc487c1f0915ba692c140f866835321e2672f79ac42dcc1::kubo {
    struct KUBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUBO>(arg0, 6, b"KUBO", b"Kubo Bear", x"4a757374204b75626f2e0a492065786973742c204920747269702c2049206e61702e20536f6d6574696d6573204920706f7374207468696e67732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000069626_a4a684a931.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

