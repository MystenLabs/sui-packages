module 0x68a95f03a9cbbf5b99facd9b03c6ca2ede24585ab4bee074d85698281feb0de5::tho {
    struct THO has drop {
        dummy_field: bool,
    }

    fun init(arg0: THO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THO>(arg0, 6, b"THO", b"Tho", b"description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://guitarzone.vn/wp-content/uploads/2023/05/coin_icon.png")), arg1);
        let v2 = v0;
        0x2::pay::keep<THO>(0x2::coin::from_balance<THO>(0x2::coin::mint_balance<THO>(&mut v2, 10000000000), arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

