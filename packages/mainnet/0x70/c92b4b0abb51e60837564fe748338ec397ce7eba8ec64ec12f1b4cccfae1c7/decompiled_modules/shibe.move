module 0x70c92b4b0abb51e60837564fe748338ec397ce7eba8ec64ec12f1b4cccfae1c7::shibe {
    struct SHIBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBE>(arg0, 6, b"SHIBE", b"ShibeRise", b"ShibeRise is the next-generation meme coin inspired by the legendary Shiba Inu, reborn to conquer the cosmos of crypto with community power and infinite meme energy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigtr3j6l4nhphdc3e7w5p5qun4zhp3takzjo6ni2rd2etrpbgiga4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHIBE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

