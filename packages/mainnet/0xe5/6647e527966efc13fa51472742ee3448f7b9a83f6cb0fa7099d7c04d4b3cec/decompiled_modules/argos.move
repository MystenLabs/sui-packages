module 0xe56647e527966efc13fa51472742ee3448f7b9a83f6cb0fa7099d7c04d4b3cec::argos {
    struct ARGOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARGOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARGOS>(arg0, 6, b"ARGOS", b"Argos", b"Argos Token (ARGOS), crowned as the king of dog tokens, is a community-driven cryptocurrency on the Sui Blockchain, inspired by the loyalty and courage of dogs. It fuels AI solutions, Web3 innovations, gaming, DeFi, NFTs, and payment integrations, blending innovation with compassion to redefine blockchain's future. Argos strives for global adoption as a leading cryptocurrency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Argos_Logo_2566bfe8b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARGOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARGOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

