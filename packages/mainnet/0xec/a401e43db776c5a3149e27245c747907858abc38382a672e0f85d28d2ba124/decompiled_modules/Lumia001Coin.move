module 0xeca401e43db776c5a3149e27245c747907858abc38382a672e0f85d28d2ba124::Lumia001Coin {
    struct LUMIA001COIN has drop {
        dummy_field: bool,
    }

    struct MintCoinEvent has copy, drop {
        amt: u64,
        recp: address,
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LUMIA001COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LUMIA001COIN>>(0x2::coin::mint<LUMIA001COIN>(arg0, arg1 * 1000000, arg3), arg2);
        let v0 = MintCoinEvent{
            amt  : arg1,
            recp : arg2,
        };
        0x2::event::emit<MintCoinEvent>(v0);
    }

    fun init(arg0: LUMIA001COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUMIA001COIN>(arg0, 6, b"LUMIA001COIN", b"LUMIA001COIN", b"LUMIA001COIN description.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LUMIA001COIN>(&mut v2, 100 * 1000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUMIA001COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUMIA001COIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

