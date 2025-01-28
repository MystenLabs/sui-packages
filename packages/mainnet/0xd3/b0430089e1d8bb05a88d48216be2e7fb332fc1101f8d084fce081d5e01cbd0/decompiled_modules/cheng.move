module 0xd3b0430089e1d8bb05a88d48216be2e7fb332fc1101f8d084fce081d5e01cbd0::cheng {
    struct CHENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHENG>(arg0, 6, b"CHENG", b"EVAN CHENG", b"This is the official space for all things Evan Cheng Pixel art and our meme coin !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_Logo_489d064f17.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

