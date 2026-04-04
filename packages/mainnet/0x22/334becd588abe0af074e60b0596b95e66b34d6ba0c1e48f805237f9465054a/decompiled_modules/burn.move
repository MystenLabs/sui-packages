module 0x22334becd588abe0af074e60b0596b95e66b34d6ba0c1e48f805237f9465054a::burn {
    struct BURN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775271541825-9c33cdf8a2be71647d033112134414eb.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775271541825-9c33cdf8a2be71647d033112134414eb.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<BURN>(arg0, 9, b"BURN", b"Burn Coin", b"Burn Coin inspired By Burn Team", v1, arg1);
        let v4 = v2;
        if (21000000000000000 > 0) {
            0x2::coin::mint_and_transfer<BURN>(&mut v4, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURN>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BURN>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

