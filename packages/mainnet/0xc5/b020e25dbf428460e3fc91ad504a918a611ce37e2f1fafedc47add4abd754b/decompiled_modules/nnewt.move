module 0xc5b020e25dbf428460e3fc91ad504a918a611ce37e2f1fafedc47add4abd754b::nnewt {
    struct NNEWT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNEWT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NNEWT>(arg0, 6, b"NNEWT", b"NIFTY NEWT", b"Slippery, smooth, and always full of surprises. Nifty Newt is sliding into meme greatness.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_035222144_3019e3da6b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNEWT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NNEWT>>(v1);
    }

    // decompiled from Move bytecode v6
}

