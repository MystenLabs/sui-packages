module 0xd4ba524096187892cf7d9949ddec24a2653d4832d12e66361da3a249be74cde9::tap {
    struct TAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAP>(arg0, 6, b"TAP", b"TapSui", x"796f75206d69737365642024706c6f702c20646f6e2774206d69737320245441500a0a2020546170205461702054617020546170205461702020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tap_pfp_1487cb5a8e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

