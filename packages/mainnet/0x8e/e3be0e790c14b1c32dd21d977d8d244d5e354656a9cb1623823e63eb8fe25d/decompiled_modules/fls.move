module 0x8ee3be0e790c14b1c32dd21d977d8d244d5e354656a9cb1623823e63eb8fe25d::fls {
    struct FLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLS>(arg0, 6, b"FLS", b"FeLix", b"I'm from ETH, give me some time I'll update all the things we need, we have a new path for the future and most of all now what we're aiming for in the presale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_12_00_10_54_cae9d09b81.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

