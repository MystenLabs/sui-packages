module 0xf11091c8809a3b4b6f9e39614e473d8ccf118fb88b6c6e2e710e48d2c7f65d32::hog {
    struct HOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOG>(arg0, 6, b"HOG", b"Hose Dog", b"F*ck with the SUI hose and the SUI hose f*ucks back. Meme dedicated to creating a community around pets f*ucking around and finding out. Post your pets greatest achievement's in the chat we want to see them. Socials once community is onboard.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0276_b279065731_36d69d067c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

