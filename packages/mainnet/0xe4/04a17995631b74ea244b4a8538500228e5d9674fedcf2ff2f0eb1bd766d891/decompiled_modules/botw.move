module 0xe404a17995631b74ea244b4a8538500228e5d9674fedcf2ff2f0eb1bd766d891::botw {
    struct BOTW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOTW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOTW>(arg0, 6, b"BoTW", b"BUTTON WAR (SvS)", b"Buttonwar is a meme token designed to ignite the rivalry between the Sui and Solana blockchains. The token features playful competitive elements, represented by mascots and button-themed imagery aimed at degen traders and crypto enthusiasts!11", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1732535410880_798b9d7c67.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOTW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOTW>>(v1);
    }

    // decompiled from Move bytecode v6
}

