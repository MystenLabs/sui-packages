module 0x4b0018b730af4a0548f2d39950bc45ed1a59592b93e2eb127c22fcf20971471f::skelsui {
    struct SKELSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKELSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKELSUI>(arg0, 6, b"SKELSUI", b"SKELETON", b"Bound by an ironclad code of ethics, the SKELSUI crew carve out a corner of the crypto wilds where trust isnt just a buzzword, its the foundation. The SKELSUI crew doesn't rug. No central overlords, no shady devs, just a skeleton crew dedicated to keeping it real. Join the crypt. Thrive where others rot.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidr3x5pspp52u5wlxjkhawoflfcvqgf7ls4uex4a2wr6w7qlm4vke")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKELSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SKELSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

