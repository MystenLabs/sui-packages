module 0x4df37ae9dc8c4169d6dd3fd6ebff3ef25ecf015036994f7a029e9e337c2cdf10::chow {
    struct CHOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOW>(arg0, 6, b"CHOW", b"CHOWSUI", b"There is no cabal. Only CHOW CHOW.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/h_1_ZY_5_a_400x400_d616f86bc7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

