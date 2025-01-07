module 0x77733f745be30c0c183e7b3b614d011c35313f72912b60c040c2e6532c27fdbd::xmas {
    struct XMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XMAS>(arg0, 6, b"XMAS", b"25.12.24Surprise", b"There will be no TG, X and Web links. It's just a MEME isn't it. I will buy my 8 SUI worthy of tokens. Have fun. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8412_78dc79bbbe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

