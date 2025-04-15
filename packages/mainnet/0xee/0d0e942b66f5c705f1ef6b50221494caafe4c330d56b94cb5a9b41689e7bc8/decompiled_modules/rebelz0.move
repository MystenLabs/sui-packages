module 0xee0d0e942b66f5c705f1ef6b50221494caafe4c330d56b94cb5a9b41689e7bc8::rebelz0 {
    struct REBELZ0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: REBELZ0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REBELZ0>(arg0, 6, b"REBELZ0", b"REBELZ", b"Rebelz was born from a belief in breaking the rules. While some claim the Sui memecoin wave is fading, Rebelz is here to prove otherwise!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreiejnerfcm2knhqqkz6zfzdo6opaq55dfggtkssqfnolyllmd7kotm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REBELZ0>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REBELZ0>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

