module 0xf74d3635a2d0294d5f3d4c3c9aea5c95f52ebd3c9d8a2e5af6f49f6601adbab5::ryan {
    struct RYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<RYAN>(arg0, 9, b"RYAN", b"Ryan", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://winx.io/WIN.svg")), true, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RYAN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RYAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<RYAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

