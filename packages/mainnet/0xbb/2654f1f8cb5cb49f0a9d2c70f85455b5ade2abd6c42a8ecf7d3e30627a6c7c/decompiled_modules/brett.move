module 0xbb2654f1f8cb5cb49f0a9d2c70f85455b5ade2abd6c42a8ecf7d3e30627a6c7c::brett {
    struct BRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETT>(arg0, 9, b"BRETT", b"BREET", b"HE'S BLUE.HE'S FAT.HE'S BASED AS FUCK.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/kDKv9JP")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BRETT>(&mut v2, 6942000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

