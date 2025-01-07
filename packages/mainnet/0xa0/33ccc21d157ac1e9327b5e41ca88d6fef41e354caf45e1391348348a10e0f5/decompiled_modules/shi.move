module 0xa033ccc21d157ac1e9327b5e41ca88d6fef41e354caf45e1391348348a10e0f5::shi {
    struct SHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHI>(arg0, 6, b"Shi", b"Suishi", b"First Edible token on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b445f68b_a75c_4d40_a7d1_ed4b71540901_6d892c36bc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

