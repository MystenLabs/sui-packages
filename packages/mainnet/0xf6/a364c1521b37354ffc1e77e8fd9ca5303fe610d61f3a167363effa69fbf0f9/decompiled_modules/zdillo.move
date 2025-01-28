module 0xf6a364c1521b37354ffc1e77e8fd9ca5303fe610d61f3a167363effa69fbf0f9::zdillo {
    struct ZDILLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZDILLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZDILLO>(arg0, 6, b"ZDILLO", b"Zylo Dillo", b"The most unique memecoin of 2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030681_69ef799f84.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZDILLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZDILLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

