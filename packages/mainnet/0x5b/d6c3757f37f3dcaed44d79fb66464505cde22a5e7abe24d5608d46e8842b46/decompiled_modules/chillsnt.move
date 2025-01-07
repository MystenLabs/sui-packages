module 0x5bd6c3757f37f3dcaed44d79fb66464505cde22a5e7abe24d5608d46e8842b46::chillsnt {
    struct CHILLSNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLSNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLSNT>(arg0, 9, b"CHILLSNT", b"CHILL SANTA", b"$CHILLSNT: Chill Santa is here to bring some chilly vibes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreibm4bcryh7mpc22wlklykg5xpadmlfbjbw3tauk7je2k4xixmz22m.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHILLSNT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLSNT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLSNT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

