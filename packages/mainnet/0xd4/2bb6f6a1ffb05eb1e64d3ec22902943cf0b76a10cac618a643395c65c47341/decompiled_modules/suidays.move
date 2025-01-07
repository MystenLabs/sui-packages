module 0xd42bb6f6a1ffb05eb1e64d3ec22902943cf0b76a10cac618a643395c65c47341::suidays {
    struct SUIDAYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDAYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDAYS>(arg0, 9, b"SUIDAYS", b"SUIDAYS", b"SUIDAYS Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIDAYS>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDAYS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDAYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

