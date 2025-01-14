module 0x2082cd0735a7743809fc663e3190affc9f89dc51265edf838412e67babdddeb::tenso_ai {
    struct TENSO_AI has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TENSO_AI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TENSO_AI>>(0x2::coin::mint<TENSO_AI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TENSO_AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TENSO_AI>(arg0, 9, b"TENAI", b"TENSO AI", b"TENSO AI token on the Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/tJ83jBQ1/T-image.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::coin::mint<TENSO_AI>(&mut v2, 1500000000000, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TENSO_AI>>(0x2::coin::split<TENSO_AI>(&mut v3, 1000000000000, arg1), @0x9752d337036cfbb6a91dae286ad3840a419475ea0e8162ab3a39b888ddd8931);
        let v4 = 250000000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<TENSO_AI>>(0x2::coin::split<TENSO_AI>(&mut v3, v4, arg1), @0xe2f6e1d10584c74264e84f3bd4faa9d0139e194d38216c0e807723441240d167);
        0x2::transfer::public_transfer<0x2::coin::Coin<TENSO_AI>>(0x2::coin::split<TENSO_AI>(&mut v3, v4, arg1), @0x9068681c94d578cc4fe28b23149c4ee996fcdde6111183e60e072bdfdd37bfd7);
        if (0x2::coin::value<TENSO_AI>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TENSO_AI>>(v3, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<TENSO_AI>(v3);
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TENSO_AI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TENSO_AI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

