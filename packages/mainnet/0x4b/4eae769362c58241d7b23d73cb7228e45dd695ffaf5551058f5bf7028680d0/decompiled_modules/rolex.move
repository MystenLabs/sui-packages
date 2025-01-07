module 0x4b4eae769362c58241d7b23d73cb7228e45dd695ffaf5551058f5bf7028680d0::rolex {
    struct ROLEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROLEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROLEX>(arg0, 9, b"ROLEX", b"ROLEX", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXzH-8Y-zWHlIiU8erY3Leo5Rwv04KIJtzCQ&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ROLEX>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROLEX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROLEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

