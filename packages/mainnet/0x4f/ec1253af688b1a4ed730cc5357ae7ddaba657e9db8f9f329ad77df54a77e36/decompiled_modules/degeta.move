module 0x4fec1253af688b1a4ed730cc5357ae7ddaba657e9db8f9f329ad77df54a77e36::degeta {
    struct DEGETA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGETA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGETA>(arg0, 6, b"DEGETA", b"Degen Vegeta", b"the prince of degens never loses a trade", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0813_648073441e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGETA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEGETA>>(v1);
    }

    // decompiled from Move bytecode v6
}

