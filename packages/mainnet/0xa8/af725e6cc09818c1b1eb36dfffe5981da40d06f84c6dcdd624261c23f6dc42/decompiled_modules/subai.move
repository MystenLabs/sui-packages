module 0xa8af725e6cc09818c1b1eb36dfffe5981da40d06f84c6dcdd624261c23f6dc42::subai {
    struct SUBAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUBAI>(arg0, 6, b"SUBAI", b"SUBAI", b"Experience the power of Subly AI Subtitlesreal-time, accurate, and customizable captions that transform how you watch and connect with video content.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://subaizheng.com/wp-content/uploads/2023/08/sign.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUBAI>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUBAI>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBAI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

