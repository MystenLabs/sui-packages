module 0x689145e1a39ceb917fdb02678444d022e2a42571443e6436e1a73564cb4226ef::bearify {
    struct BEARIFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEARIFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEARIFY>(arg0, 6, b"BEARIFY", b"BearifyOnSui", b"Welcome to Bearify, where \"Being a bear is a vibe!\" Our mascot, Vibin Bear Girl, is all about that cozy, laid-back life. Were here to help you embrace your inner bearsnuggle up, chill out, and live life with a big bear hug! Join the tribe and vibe with us in style.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bearify_0c86395aea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEARIFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEARIFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

