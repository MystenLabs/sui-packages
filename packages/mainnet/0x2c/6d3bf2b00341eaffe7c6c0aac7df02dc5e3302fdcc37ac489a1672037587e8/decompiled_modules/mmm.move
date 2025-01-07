module 0x2c6d3bf2b00341eaffe7c6c0aac7df02dc5e3302fdcc37ac489a1672037587e8::mmm {
    struct MMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMM>(arg0, 6, b"MMM", b"Mr. MeMe", b"Mr. MeMe IS THE SOCIAL LAYER AND COMMUNITY MEME COIN WITH DEEP INTEGRATIONS AS A UTILITY TOKEN ACROSS A WIDE BASE OF APPLICATIONS AND PROTOCOLS WITHIN THE WEB3 ECOSYSTEM. WE AIM TO ACHIEVE THIS LATER THIS YEAR.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo2_d28acf84b1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

