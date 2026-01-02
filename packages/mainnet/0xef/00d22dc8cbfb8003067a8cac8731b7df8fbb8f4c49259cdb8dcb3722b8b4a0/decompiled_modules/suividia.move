module 0xef00d22dc8cbfb8003067a8cac8731b7df8fbb8f4c49259cdb8dcb3722b8b4a0::suividia {
    struct SUIVIDIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVIDIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVIDIA>(arg0, 6, b"SUIVIDIA", b"Nvidia STOCKSUI", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIVIDIA>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIVIDIA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIVIDIA>>(v2);
    }

    // decompiled from Move bytecode v6
}

