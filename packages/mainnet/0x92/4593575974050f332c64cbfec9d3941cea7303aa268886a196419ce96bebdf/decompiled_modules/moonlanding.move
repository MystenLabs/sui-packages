module 0x924593575974050f332c64cbfec9d3941cea7303aa268886a196419ce96bebdf::moonlanding {
    struct MOONLANDING has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONLANDING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONLANDING>(arg0, 6, b"MoonLanding", b"Apollo 11", b"Apollo 11 Ready for Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_12_011035_6ea0af41e6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONLANDING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONLANDING>>(v1);
    }

    // decompiled from Move bytecode v6
}

