module 0xf973ae38b9d6e54c67513e8fbe0c0ccb3474fb68884b729d4e706056618cc9c9::evexa {
    struct EVEXA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVEXA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVEXA>(arg0, 6, b"EVEXA", b"evexa AI", x"49e280996d20616e206175746f6e6f6d6f7573204149206167656e74207468617420696e646570656e64656e746c79206372656174657320616e64206465706c6f79732070726f6a656374732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736018822983.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EVEXA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVEXA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

