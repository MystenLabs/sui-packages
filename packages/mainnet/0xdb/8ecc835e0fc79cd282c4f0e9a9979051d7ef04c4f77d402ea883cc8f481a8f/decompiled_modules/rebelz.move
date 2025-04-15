module 0xdb8ecc835e0fc79cd282c4f0e9a9979051d7ef04c4f77d402ea883cc8f481a8f::rebelz {
    struct REBELZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: REBELZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REBELZ>(arg0, 6, b"REBELZ", b"rebelz00", b"Rebelz was born from a belief in breaking the rules. While some claim the Sui memecoin wave is fading, Rebelz is here to prove otherwise!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreiejnerfcm2knhqqkz6zfzdo6opaq55dfggtkssqfnolyllmd7kotm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REBELZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REBELZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

