module 0xe6c04b9d5ccb3204daedfe2d7ce62a5ce0bfd71d720e162faf045e5cc213b6f0::subai {
    struct SUBAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUBAI>(arg0, 9, b"SUBAI", b"Subly AI", b"Experience the power of Subly AI Subtitlesreal-time, accurate, and customizable captions that transform how you watch and connect with video content.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWca3tHUPLsgqS21bA9YdgqdDYD6koRtdNbbWa2zkE555")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUBAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUBAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

