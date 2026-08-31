module 0x82de93ad0d8d4a7bae01ef63f40e47f480d4ba106b1dda0922e03c61a3c5c68e::safeva_bdc3f7831f36ffae {
    struct SAFEVA_BDC3F7831F36FFAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAFEVA_BDC3F7831F36FFAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAFEVA_BDC3F7831F36FFAE>(arg0, 0, b"SAFEVA", b"Signed Launch Smoke HAFEVA", b"Browser-style signed launch verification token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAFEVA_BDC3F7831F36FFAE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SAFEVA_BDC3F7831F36FFAE>>(0x2::coin::mint<SAFEVA_BDC3F7831F36FFAE>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAFEVA_BDC3F7831F36FFAE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

