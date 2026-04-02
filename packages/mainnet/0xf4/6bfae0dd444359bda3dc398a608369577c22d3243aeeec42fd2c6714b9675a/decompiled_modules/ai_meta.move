module 0xf46bfae0dd444359bda3dc398a608369577c22d3243aeeec42fd2c6714b9675a::ai_meta {
    struct AI_META has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI_META, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775161216942-958d3c994e18a2a0285cc85cb07f6ce1.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775161216942-958d3c994e18a2a0285cc85cb07f6ce1.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<AI_META>(arg0, 9, b"AI META", b"AI META", b"Ai Meta Coin", v1, arg1);
        let v4 = v2;
        if (10000000000000000000 > 0) {
            0x2::coin::mint_and_transfer<AI_META>(&mut v4, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI_META>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AI_META>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

