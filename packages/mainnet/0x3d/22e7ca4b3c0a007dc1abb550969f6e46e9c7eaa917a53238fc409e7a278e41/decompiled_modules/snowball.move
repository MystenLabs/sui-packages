module 0x3d22e7ca4b3c0a007dc1abb550969f6e46e9c7eaa917a53238fc409e7a278e41::snowball {
    struct SNOWBALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOWBALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOWBALL>(arg0, 6, b"SNOWBALL", b"X OFFICIAL MASCOT", b"My name is Snowball and I'm a hedgehog, I am X OFFICIAL MASCOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gd_Ehj_K_XAA_Aur3w_1044cd69d3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOWBALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOWBALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

