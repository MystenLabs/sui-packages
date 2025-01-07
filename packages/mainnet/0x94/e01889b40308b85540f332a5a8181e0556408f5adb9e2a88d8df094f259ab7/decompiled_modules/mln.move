module 0x94e01889b40308b85540f332a5a8181e0556408f5adb9e2a88d8df094f259ab7::mln {
    struct MLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MLN>(arg0, 6, b"MLN", b"Melin de Meme by SuiAI", b"Melin de Meme roams the virtual world in search of his magical wand ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Melin1_ace3dfaf97.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MLN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

