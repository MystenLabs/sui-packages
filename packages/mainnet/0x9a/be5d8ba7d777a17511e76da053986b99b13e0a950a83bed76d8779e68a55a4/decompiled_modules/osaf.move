module 0x9abe5d8ba7d777a17511e76da053986b99b13e0a950a83bed76d8779e68a55a4::osaf {
    struct OSAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAF>(arg0, 6, b"OSAF", b"OSAF - MATTFURIE", b"Born from Matt Furies imagination, Orang Sad Frogger (OSAF) is more than a meme coin. Its a community embracing lifes bittersweet moments.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_2_084c5521f3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSAF>>(v1);
    }

    // decompiled from Move bytecode v6
}

