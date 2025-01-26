module 0x552677f20baef4dcd6d742b696c4194a88d655d54d17c35f1b2e4089910ef900::flying_rug {
    struct FLYING_RUG has drop {
        dummy_field: bool,
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

