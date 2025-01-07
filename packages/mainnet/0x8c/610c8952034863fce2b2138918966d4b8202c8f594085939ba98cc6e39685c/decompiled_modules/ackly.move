module 0x8c610c8952034863fce2b2138918966d4b8202c8f594085939ba98cc6e39685c::ackly {
    struct ACKLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACKLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACKLY>(arg0, 6, b"Ackly", b"ackchyually", b"The \"Ackchyually\" meme is a satirical representation of a stereotypical internet \"know-it-all\" or pedant. The meme often features an image of a person, usually depicted as nerdy or socially awkward, correcting someone in a condescending way. The word \"actually\" is intentionally misspelled as \"Ackchyually\" to mock the overly serious and nitpicky attitude of those who feel the need to correct minor details or offer unsolicited information. The character in the meme usually comes across as overly confident while missing the bigger picture or missing the joke entirely.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6124_94f8ec0de6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACKLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACKLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

