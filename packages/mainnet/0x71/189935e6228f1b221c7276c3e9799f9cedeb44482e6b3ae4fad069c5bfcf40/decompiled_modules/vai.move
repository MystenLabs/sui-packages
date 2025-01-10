module 0x71189935e6228f1b221c7276c3e9799f9cedeb44482e6b3ae4fad069c5bfcf40::vai {
    struct VAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VAI>(arg0, 6, b"VAI", b"VIRTUAL AI by SuiAI", b"VIRTUAL AI ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images_13_797d881c38.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

