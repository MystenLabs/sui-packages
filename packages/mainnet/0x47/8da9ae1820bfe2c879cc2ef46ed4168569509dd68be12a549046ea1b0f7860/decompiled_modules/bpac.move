module 0x478da9ae1820bfe2c879cc2ef46ed4168569509dd68be12a549046ea1b0f7860::bpac {
    struct BPAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPAC>(arg0, 6, b"BPAC", b"Pixel Ape Coin", b"Pixel Ape Coin (BPAC) is a meme-inspired cryptocurrency designed to power the Pixel Apes NFT ecosystem. Built on the Sui blockchain, BPAC aims to create an engaging and rewarding experience for both NFT holders and the broader Pixel Apes community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A74_E4_F8_F_6_E34_4348_B4_C6_C4275488_EA_18_9c91f66743.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

