module 0xe365488d0b9014a75cfc69d2b8ead4ef453b01359b0ecc6b3242bba5375ba000::grai {
    struct GRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRAI>(arg0, 6, b"GRAI", b"GrAIscale AI", b"GrAIscale is innovating Web3 investment as the first SAFU fund specializing in memes and AI agents, aiming to surpass grayscale.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicfnmaceejlgryoldf5meelrbkav4vs6dmm24r4oe7aifwqqaz54a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GRAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

