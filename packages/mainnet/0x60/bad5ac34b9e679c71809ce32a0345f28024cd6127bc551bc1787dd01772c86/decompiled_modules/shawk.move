module 0x60bad5ac34b9e679c71809ce32a0345f28024cd6127bc551bc1787dd01772c86::shawk {
    struct SHAWK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAWK>(arg0, 9, b"SHAWK", b"SHAWK", b"HODL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dexscreener.com/cms/images/yE0NNctXSonIcyCN?width=56&height=56&fit=crop&quality=95&format=auto")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHAWK>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAWK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAWK>>(v1);
    }

    // decompiled from Move bytecode v6
}

