module 0xbf82450b104e6a498003f8effb201647dbc06a41cd7c919dcb1157e06561ee0b::bff {
    struct BFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFF>(arg0, 6, b"BFF", b"Builtfromfracture", b"Built From Fracture (BFF) is more than a token its the foundation of a growing ecosystem built on Sui. NFTs, games, staking, the Fracture Engine, Fracture Vault, utilities, community initiatives, and real-world businesses all contribute to building something bigger than a single project. Every setback can become a foundation. BREAK. BUILD. BECOME.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidbghgidojxq4vprhrcajku3gm4teqekyp4if5x4cfnprv7qvlkye")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BFF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

