module 0xaf60c493a1477f6be1abe0fcf8e1f3e2ac034fc6c61aaac4d6a422388b6c13b1::ai_penguin {
    struct AI_PENGUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI_PENGUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776558283072-3a46dd9ad0f3a3d0c01246a02deb8a2f.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776558283072-3a46dd9ad0f3a3d0c01246a02deb8a2f.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<AI_PENGUIN>(arg0, 9, b"AI PENGUIN", b"AI PENGUIN", b"AI", v1, arg1);
        let v4 = v2;
        if (8000000000000000 > 0) {
            0x2::coin::mint_and_transfer<AI_PENGUIN>(&mut v4, 8000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI_PENGUIN>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AI_PENGUIN>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

