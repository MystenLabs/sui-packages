module 0x9999fd52cc571dd30d0e914e80c57401b5b65434de4ff3bae3f0f9b97c8e5a93::tho {
    struct THO has drop {
        dummy_field: bool,
    }

    fun init(arg0: THO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THO>(arg0, 6, b"THO", b"Tho", b"description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://guitarzone.vn/wp-content/uploads/2023/05/coin_icon.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<THO>(&mut v2, 42, 0x2::tx_context::sender(arg1), arg1);
        0x2::pay::keep<THO>(0x2::coin::from_balance<THO>(0x2::coin::mint_balance<THO>(&mut v2, 1000), arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

