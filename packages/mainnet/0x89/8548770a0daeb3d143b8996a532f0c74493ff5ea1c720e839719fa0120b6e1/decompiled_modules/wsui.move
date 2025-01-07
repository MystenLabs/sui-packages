module 0x898548770a0daeb3d143b8996a532f0c74493ff5ea1c720e839719fa0120b6e1::wsui {
    struct WSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSUI>(arg0, 9, b"WSUI", b"WSUI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<WSUI>>(0x2::coin::mint<WSUI>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WSUI>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

