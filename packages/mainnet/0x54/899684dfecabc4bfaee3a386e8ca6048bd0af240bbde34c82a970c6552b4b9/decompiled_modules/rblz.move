module 0x54899684dfecabc4bfaee3a386e8ca6048bd0af240bbde34c82a970c6552b4b9::rblz {
    struct RBLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBLZ>(arg0, 6, b"RBLZ", b"REBELZ", b"Rebelz was born from a belief in breaking the rules. While some claim the Sui memecoin wave is fading, Rebelz is here to prove otherwise reviving the spirit of memecoins and breathing new life into the Sui ecosystem. Join us as we bring back the energy, creativity, and community that made Sui memecoins great.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreig3xjgypue6x6n3usbuop4cryn5ffhstxpumu7z2ipnkrxw2emwem")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBLZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RBLZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

