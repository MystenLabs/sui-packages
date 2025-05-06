module 0x2909441a3e41ac028ef238baba40fdee10969b3d14df03d16854a823ec1d6792::furry {
    struct FURRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FURRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FURRY>(arg0, 6, b"FURRY", b"SUI FURRY", b"SUI FURRY is the first 100% community-driven meme token on the Sui blockchain, combining decentralized finance with meme culture in a sustainable ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigkmmxqsbfczf3qutm54fmf7vctk4m633372rgtyrt7yednbckdim")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FURRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FURRY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

