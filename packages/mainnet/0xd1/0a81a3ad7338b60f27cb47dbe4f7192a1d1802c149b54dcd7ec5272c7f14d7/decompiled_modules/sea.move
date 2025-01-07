module 0xd10a81a3ad7338b60f27cb47dbe4f7192a1d1802c149b54dcd7ec5272c7f14d7::sea {
    struct SEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEA>(arg0, 6, b"SEA", b"Serial Experiment AI", b"connected throught the network we are all in harmony with god. wake up. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736062415981.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

