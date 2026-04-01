module 0x39a6911a2e1bd39ee63909957bf68d99000aebede6dd325173d2add494dc82e2::shiba_ai {
    struct SHIBA_AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBA_AI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775073126738-1f39942ef6de1b3df3f9ebc6132c6d61.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775073126738-1f39942ef6de1b3df3f9ebc6132c6d61.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<SHIBA_AI>(arg0, 9, b"Shiba AI", b"Shiba Ai Coin", b"Shiba Ai Token is Now Launch on cetus", v1, arg1);
        let v4 = v2;
        if (5000000000000000000 > 0) {
            0x2::coin::mint_and_transfer<SHIBA_AI>(&mut v4, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBA_AI>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHIBA_AI>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

