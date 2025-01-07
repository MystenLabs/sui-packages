module 0xfb84e9dfedde404b4c51b2955b1d5990dc3db95b97557aa56c5e21366193528a::waterdoge {
    struct WATERDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATERDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATERDOGE>(arg0, 9, b"WATERDOGE", b"Water Doge", b"Water doge is meme on sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844785639491076096/l0o0atbB.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WATERDOGE>(&mut v2, 450000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATERDOGE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATERDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

