module 0x25c5c72b67143e46f0474d4273f4f0d0b59072a4113df95dc0ec6944c100e766::odg {
    struct ODG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODG>(arg0, 6, b"ODG", b"OceanDoge", b"ceanDoge | The memecoin riding the waves on the Sui network. Big meme energy, wild community, saving the ecosystem one token at a time. #OceanDoge #SuiNet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiebfylfbcnlmybees6grhisjkt23hwnzydxmxbqup4eljbjbr5bgq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ODG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

