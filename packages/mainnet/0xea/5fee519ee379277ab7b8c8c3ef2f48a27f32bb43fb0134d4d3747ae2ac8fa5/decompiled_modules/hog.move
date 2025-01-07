module 0xea5fee519ee379277ab7b8c8c3ef2f48a27f32bb43fb0134d4d3747ae2ac8fa5::hog {
    struct HOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOG>(arg0, 6, b"HOG", b"Hose Dog", b"F*ck with the SUI hose and the SUI hose f*ucks back. Meme dedicated to creating a community around pets f*ucking around and finding out. Post your pets greatest achievement's in the chat we want to see them. Socials once community is onboard.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture1_2842f2da77.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

