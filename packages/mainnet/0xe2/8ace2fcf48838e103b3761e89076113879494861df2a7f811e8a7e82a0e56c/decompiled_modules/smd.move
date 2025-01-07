module 0xe28ace2fcf48838e103b3761e89076113879494861df2a7f811e8a7e82a0e56c::smd {
    struct SMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMD>(arg0, 6, b"SMD", b"SuiMuskDeer", b"After killing the Musk deer, they cut off its Musk gland or its testicle and then dry it under the sun, science and technology helped for saving Musks, this meme token is done to remind that tech and science will help us all, like Musks deers have been helped before.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2f53665858.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

