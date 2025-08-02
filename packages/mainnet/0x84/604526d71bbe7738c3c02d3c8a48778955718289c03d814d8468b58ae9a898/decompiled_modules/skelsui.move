module 0x84604526d71bbe7738c3c02d3c8a48778955718289c03d814d8468b58ae9a898::skelsui {
    struct SKELSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKELSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKELSUI>(arg0, 6, b"SKELSUI", b"SKELETON", b"The SKELSUI crew doesnt rug. Bound by an ironclad code of ethics, they carve out a corner of the crypto wilds where trust isnt just a buzzwordits the foundation.In the SKELSUI crypt, holders arent just bagholderstheyre rebels, creators, and dreamers building a decentralized future. From the glowing skulls of the O.G. SKELSUI to the rare GlitchBones with their pixelated swagger, each token pulses with the spirit of a community that values every voice. No central overlords, no shady devsjust a skeleton crew dedicated to keeping it real. Grab your SKELSUI. Join the crypt. Thrive where others rot.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidr3x5pspp52u5wlxjkhawoflfcvqgf7ls4uex4a2wr6w7qlm4vke")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKELSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SKELSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

