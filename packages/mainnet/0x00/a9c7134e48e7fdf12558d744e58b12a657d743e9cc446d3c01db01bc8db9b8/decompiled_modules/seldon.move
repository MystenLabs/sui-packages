module 0xa9c7134e48e7fdf12558d744e58b12a657d743e9cc446d3c01db01bc8db9b8::seldon {
    struct SELDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SELDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SELDON>(arg0, 6, b"SELDON", b"Seldon Lycurgus Musk", x"53656c646f6e204c79637572677573204d75736b2e200a31342e200a4f6666696369616c2053756920426c6f636b636861696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000098_525f963f23.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SELDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SELDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

