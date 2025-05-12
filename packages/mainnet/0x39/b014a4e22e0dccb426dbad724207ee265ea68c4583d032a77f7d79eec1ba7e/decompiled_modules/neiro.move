module 0x39b014a4e22e0dccb426dbad724207ee265ea68c4583d032a77f7d79eec1ba7e::neiro {
    struct NEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRO>(arg0, 6, b"NEIRO", b"Doge Neirox", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEIRO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

