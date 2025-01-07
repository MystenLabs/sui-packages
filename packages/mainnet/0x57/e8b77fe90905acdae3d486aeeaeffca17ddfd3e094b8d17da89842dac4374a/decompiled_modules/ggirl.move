module 0x57e8b77fe90905acdae3d486aeeaeffca17ddfd3e094b8d17da89842dac4374a::ggirl {
    struct GGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGIRL>(arg0, 9, b"GGIRL", b"Gangster Girl", b"GGIRL IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/366/025/large/rui-guo-11133.jpg?1727368168")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GGIRL>(&mut v2, 30000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGIRL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GGIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

