module 0x129b3cce9b4191e7af908e05e022e16539459bad9b06726a0638de8a040a41b7::msga {
    struct MSGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSGA>(arg0, 9, b"MSGA", b"MakeSuiGreatAgain", b"Only hold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/AhBBWzKfgSgXc4NTXxqvcziXcMQPv6TcfFnTu4yrBaJH/header.png?size=xl&key=895d81")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MSGA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSGA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

