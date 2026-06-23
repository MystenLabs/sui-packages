module 0x1ea61c850d03a9f825243b5c362f85b8ca827656c653c8ec15920f6027472532::mn {
    struct MN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b""))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<MN>(arg0, 9, b"MN", b"Mesh Network", b"Mesh Network One Of the Largest Network", v1, arg1);
        let v4 = v2;
        if (2100000000000000000 > 0) {
            0x2::coin::mint_and_transfer<MN>(&mut v4, 2100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MN>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MN>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

