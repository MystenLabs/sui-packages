module 0x6c63c87d1e0d93ab5eca98f8b8125a9d7a03bc2467229e0885c7e6e223189a22::reb00 {
    struct REB00 has drop {
        dummy_field: bool,
    }

    fun init(arg0: REB00, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REB00>(arg0, 6, b"REB00", b"rebelz00 on MOONBAG", b"Rebelz was born from a belief in breaking the rules. While some claim the Sui memecoin wave is fading, Rebelz is here to prove otherwise!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreiejnerfcm2knhqqkz6zfzdo6opaq55dfggtkssqfnolyllmd7kotm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REB00>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REB00>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

