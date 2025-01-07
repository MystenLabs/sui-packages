module 0xae95a2db175b4708240f9b6ea5d720411be227b84be9a304b66764a0f54e9aab::aibo {
    struct AIBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIBO>(arg0, 6, b"AIBO", b"AIBO Suite", b"AI Bot (Agent Sui-te) 007, The ultimate BOT meme token for the SUI blockchain AI revolution!  Combining the power of bots, brains, and blockchain, AI Bot Suite is here to automate fun, generate memes, and bring utility to the world of AI-powered crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/eb5ec601_a95c_407d_89fb_d990a7b146f5_watermarked_video07d1e39b26fee4862acadc6b1dc3c01e3_63d9c608a7.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

