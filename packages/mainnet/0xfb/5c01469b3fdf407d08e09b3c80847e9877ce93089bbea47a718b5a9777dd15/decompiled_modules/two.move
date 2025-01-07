module 0xfb5c01469b3fdf407d08e09b3c80847e9877ce93089bbea47a718b5a9777dd15::two {
    struct TWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWO>(arg0, 6, b"TWO", b"SUI TO $2", b"Lets push SUI to two dollars, y'all", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2d_5b12b14386.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

