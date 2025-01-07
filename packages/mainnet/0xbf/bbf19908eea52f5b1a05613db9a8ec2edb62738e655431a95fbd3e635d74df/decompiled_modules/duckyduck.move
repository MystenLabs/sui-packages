module 0xbfbbf19908eea52f5b1a05613db9a8ec2edb62738e655431a95fbd3e635d74df::duckyduck {
    struct DUCKYDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKYDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKYDUCK>(arg0, 6, b"DuckyDuck", b"SUI_DuckyDuck", b"The secret fren of Pepe, Andy, Brett, and Landwolf | Part of Matt Furie's Boys Club legacy | Join us in the quacktastic world of $DUCKY | Just Duck it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/86k_Ks6z_P_400x400_2762a5fa73.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKYDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKYDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

