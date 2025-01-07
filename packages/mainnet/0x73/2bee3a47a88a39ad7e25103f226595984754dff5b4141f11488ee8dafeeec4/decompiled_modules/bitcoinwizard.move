module 0x732bee3a47a88a39ad7e25103f226595984754dff5b4141f11488ee8dafeeec4::bitcoinwizard {
    struct BITCOINWIZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCOINWIZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCOINWIZARD>(arg0, 6, b"BitcoinWizard", b"Magic Internet Money", b"Magic Internet Money: Bitcoin Wizard refers to an advertisement for the /r/Bitcoin subreddit that features an MSPaint illustration of a wizard.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/250x250wizard_c6694a7161_a3ec8eb33b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOINWIZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITCOINWIZARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

