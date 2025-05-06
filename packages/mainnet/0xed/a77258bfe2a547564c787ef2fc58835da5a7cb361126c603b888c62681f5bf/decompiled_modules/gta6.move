module 0xeda77258bfe2a547564c787ef2fc58835da5a7cb361126c603b888c62681f5bf::gta6 {
    struct GTA6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTA6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTA6>(arg0, 6, b"GTA6", b"Grand Theft Auto VI", b"GTA 6 Coin launched on Sui after Rockstar announced that cryptocurrencies will be present in the game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiho7xtgzxyel74cssouah6cj6npxrwdioifvofs5z5bn6at6umryq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTA6>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GTA6>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

