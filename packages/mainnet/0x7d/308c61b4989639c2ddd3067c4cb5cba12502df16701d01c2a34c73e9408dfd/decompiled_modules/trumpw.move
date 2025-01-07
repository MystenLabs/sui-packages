module 0x7d308c61b4989639c2ddd3067c4cb5cba12502df16701d01c2a34c73e9408dfd::trumpw {
    struct TRUMPW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPW>(arg0, 6, b"TrumpW", b"TrumpWin", b"A meme coin predicting Trump win", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8769_508ab974b9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPW>>(v1);
    }

    // decompiled from Move bytecode v6
}

