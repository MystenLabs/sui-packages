module 0x6ab9613b52f50f95469aef834851064e54aa41e90c6f1e6f83d6b6a131993630::rez00 {
    struct REZ00 has drop {
        dummy_field: bool,
    }

    fun init(arg0: REZ00, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REZ00>(arg0, 6, b"REZ00", b"rebelz00 on SUI", b"Rebelz was born from a belief in breaking the rules. While some claim the Sui memecoin wave is fading, Rebelz is here to prove otherwise!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreiejnerfcm2knhqqkz6zfzdo6opaq55dfggtkssqfnolyllmd7kotm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REZ00>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REZ00>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

