module 0xe06a1d3939e369752859be7a83ba40023f872a43fa091ae85820dbbe525c41ff::peg {
    struct PEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEG>(arg0, 6, b"PEG", b"PEGI", b"Pegi is a meme token on the Sui blockchain, designed to captivate the community with its playful charm and potential for growth. Blending humor with decentralized finance, Pegi offers an engaging experience for both investors and meme enthusiasts, making it a fun and rewarding part of the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9febef5e_b557_41a8_a90f_b8a34204a16d_64eb2b64b3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

