module 0x10f92718e554f86e587614a511269754b7a1061055fc890aea1a0b32557064ae::predix {
    struct PREDIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PREDIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PREDIX>(arg0, 6, b"PREDIX", b"Predix", b"PREDIX is a Web3 platform built on SUI, where users can predict the SUI/USDT market direction and earn rewards.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000060330_d33f2986e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PREDIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PREDIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

