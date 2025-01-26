module 0xeb69e08c97787ab02a61cad6f3e7707f5c97bd958a4783fd6d2b8ed89310fbdb::flying_rug {
    struct FLYING_RUG has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FLYING_RUG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FLYING_RUG>>(0x2::coin::mint<FLYING_RUG>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FLYING_RUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLYING_RUG>(arg0, 9, b"FRUG", b"Flying Rug", x"466c79696e672052756720e28093204d61646520696e205475726b65792e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExYmkzNjQ5aWUwenlramN5OTNzbDY0cXFreTI2YXhhM3VldzllMmE1cSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/yXBqba0Zx8S4/giphy.gif")), arg1);
        let v2 = v0;
        let v3 = 0x2::coin::mint<FLYING_RUG>(&mut v2, 1500000000000000000, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FLYING_RUG>>(0x2::coin::split<FLYING_RUG>(&mut v3, 1000000000000000000, arg1), @0x9752d337036cfbb6a91dae286ad3840a419475ea0e8162ab3a39b888ddd8931);
        let v4 = 250000000000000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<FLYING_RUG>>(0x2::coin::split<FLYING_RUG>(&mut v3, v4, arg1), @0xe2f6e1d10584c74264e84f3bd4faa9d0139e194d38216c0e807723441240d167);
        0x2::transfer::public_transfer<0x2::coin::Coin<FLYING_RUG>>(0x2::coin::split<FLYING_RUG>(&mut v3, v4, arg1), @0x9068681c94d578cc4fe28b23149c4ee996fcdde6111183e60e072bdfdd37bfd7);
        if (0x2::coin::value<FLYING_RUG>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<FLYING_RUG>>(v3, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<FLYING_RUG>(v3);
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLYING_RUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLYING_RUG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

