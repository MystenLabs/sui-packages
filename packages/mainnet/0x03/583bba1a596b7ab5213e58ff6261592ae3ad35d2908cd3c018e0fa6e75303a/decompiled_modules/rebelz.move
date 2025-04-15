module 0x3583bba1a596b7ab5213e58ff6261592ae3ad35d2908cd3c018e0fa6e75303a::rebelz {
    struct REBELZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: REBELZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REBELZ>(arg0, 6, b"Rebelz", b"Rebelz00", b"Rebelz was born from a belief in breaking the rules. While some claim the Sui memecoin wave is fading, Rebelz is here to prove otherwise!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreiejnerfcm2knhqqkz6zfzdo6opaq55dfggtkssqfnolyllmd7kotm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REBELZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REBELZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

