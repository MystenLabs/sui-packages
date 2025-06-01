module 0x21f0b75954bcd0d37814476646ccf21fd5c84dd6876b73beaf084f0ec4f119de::keycat {
    struct KEYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEYCAT>(arg0, 6, b"KEYCAT", b"Keyboard Cat", b"Keyboard Cat is a video-based internet meme. Its original form was a 1984 video made by Charlie Schmidt of his cat Fatso appearing to play a musical keyboard to a cheerful tune.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihxowb7z2btgujwp7q23jqphkikj6rea3zl26263b26dveholtkvy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KEYCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

