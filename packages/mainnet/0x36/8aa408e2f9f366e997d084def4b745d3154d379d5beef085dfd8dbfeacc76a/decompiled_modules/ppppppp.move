module 0x368aa408e2f9f366e997d084def4b745d3154d379d5beef085dfd8dbfeacc76a::ppppppp {
    struct PPPPPPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPPPPPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPPPPPP>(arg0, 9, b"PPPPPPP", b"jjjjj", b"Deployed via Multi-Chain Token Deployer", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PPPPPPP>>(0x2::coin::mint<PPPPPPP>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PPPPPPP>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PPPPPPP>>(v1);
    }

    // decompiled from Move bytecode v7
}

