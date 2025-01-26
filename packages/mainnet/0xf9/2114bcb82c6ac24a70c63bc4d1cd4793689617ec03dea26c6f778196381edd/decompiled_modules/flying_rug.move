module 0xf92114bcb82c6ac24a70c63bc4d1cd4793689617ec03dea26c6f778196381edd::flying_rug {
    struct FLYING_RUG has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: &mut 0x2::coin::Coin<FLYING_RUG>, arg1: u64, arg2: address, arg3: &0xd85fcff61d65912b0d5a61cc99b501e0f3bb620f946b318dcd437271335142e4::validprogram::Whitelist, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id_from_address(0x2::tx_context::sender(arg4));
        assert!(0xd85fcff61d65912b0d5a61cc99b501e0f3bb620f946b318dcd437271335142e4::validprogram::is_valid(arg3, &v0), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<FLYING_RUG>>(0x2::coin::split<FLYING_RUG>(arg0, arg1, arg4), arg2);
    }

    fun init(arg0: FLYING_RUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLYING_RUG>(arg0, 9, b"FRUG", b"Flying Rug", x"466c79696e672052756720e28093204d61646520696e205475726b65792e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExYmkzNjQ5aWUwenlramN5OTNzbDY0cXFreTI2YXhhM3VldzllMmE1cSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/yXBqba0Zx8S4/giphy.gif")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FLYING_RUG>>(0x2::coin::mint<FLYING_RUG>(&mut v2, 1000000000000000000, arg1), @0x9752d337036cfbb6a91dae286ad3840a419475ea0e8162ab3a39b888ddd8931);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLYING_RUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLYING_RUG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

