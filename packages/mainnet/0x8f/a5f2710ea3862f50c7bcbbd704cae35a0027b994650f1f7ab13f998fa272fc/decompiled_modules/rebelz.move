module 0x8fa5f2710ea3862f50c7bcbbd704cae35a0027b994650f1f7ab13f998fa272fc::rebelz {
    struct REBELZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: REBELZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REBELZ>(arg0, 6, b"REBELZ", b"REBELZ SUI", b"Rebelz was born from a belief in breaking the rules. While some claim the Sui memecoin wave is fading, Rebelz is here to prove otherwise reviving the spirit of memecoins and breathing new life into the Sui ecosystem. Join us as we bring back the energy, creativity, and community that made Sui memecoins great.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig3xjgypue6x6n3usbuop4cryn5ffhstxpumu7z2ipnkrxw2emwem")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REBELZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REBELZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

