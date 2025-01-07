module 0xa2953f7c952cd36d936f2db6b638f76e66c701a7dbd91c2a5a3b15301c0f0188::csui {
    struct CSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSUI>(arg0, 6, b"Csui", b"Cryptosui", b"Cryptosui is the ultimate crypto enthusiast from the future a digital trader with a mischievous charm and a passion for all things decentralized. With coin-shaped eyes and a body made of circuits, Cryptosui is always plugged into the latest crypto trends, analyzing market charts, and making split-second trades. Whether it's Bitcoin, Ethereum, or the newest Sui token, Cryptosui's finger is always on the pulse, riding the waves of the crypto market with a playful attitude and a data-driven mind. Armed with a holographic smartphone and a flair for humor, Cryptosui shares memes, insights, and tips with the crypto community, bringing fun and knowledge to all things blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_A58_C528_90_A8_43_FE_9332_0771_C3107_D96_ff651e216d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

