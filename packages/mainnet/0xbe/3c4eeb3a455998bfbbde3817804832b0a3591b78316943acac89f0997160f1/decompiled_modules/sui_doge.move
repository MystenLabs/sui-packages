module 0xbe3c4eeb3a455998bfbbde3817804832b0a3591b78316943acac89f0997160f1::sui_doge {
    struct SUI_DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_DOGE>(arg0, 9, b"Sui Doge", b"SDOGE", b"Your easy, fun crypto trading app for buying and trading any crypto on the market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1843792880424628225/Rz12p8S5.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_DOGE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_DOGE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_DOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

