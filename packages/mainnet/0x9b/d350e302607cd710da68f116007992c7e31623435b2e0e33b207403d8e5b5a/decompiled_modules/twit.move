module 0x9bd350e302607cd710da68f116007992c7e31623435b2e0e33b207403d8e5b5a::twit {
    struct TWIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWIT>(arg0, 6, b"Twit", b"Sui Birdie", b"Twit twit! Hi, i'm Sui Birdie. The first cute pixelated GIF bird on SUI. Let's start the GIF meta on sui meme. By the way, I'm cute, right?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731921492614.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

