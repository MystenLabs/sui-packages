module 0xf60e99ce9e6d427ee245980aa7f1f649f5b143d7560e64358bc3a64c3d03a5c1::bng {
    struct BNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNG>(arg0, 9, b"BNG", b"BangVerse Token", b"In a galaxy far, far away, a cosmic meme warrior named Starlight discovered a loophole in the multiverse. With a single 'Bang!', a new universe was born, filled with absurdly hilarious and scientifically inaccurate wonders. Starlight then created the BangVerse Token to fund the expansion of this universe, allowing anyone to contribute to the chaos and receive a piece of the fun in return.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dstqcb0lj/image/upload/v1739202172/ugqol5hgbkiaahwh1unz.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

