module 0x93a6bed55f4294423bdc0f994e12980f41182032a0983aba3a1f39ad4c0c4575::cassette {
    struct CASSETTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASSETTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASSETTE>(arg0, 6, b"CASSETTE", b"Cassette on SUI", b"CASSETTE is a symbol of nostalgia pushing back against a fast-paced digital world. Amid the noise of blockchain and AI, he stands as a reminder that the past still speaks with relevance. Not just a relic, but a frequency that refuses to be silenced.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_05_01_21_00_44_9bfeeb4ec2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASSETTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASSETTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

