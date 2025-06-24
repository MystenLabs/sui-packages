module 0xe8945e4aecdde4fe8bb60bb8fe7699f9f4bf6c1a646e2c36bdd174d19c48ceda::pikha {
    struct PIKHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKHA>(arg0, 6, b"PIKHA", b"PIKACHUSUI", b"New meme onsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidvmortmsm23ftnc5xgvzbyvl3eplr67vqpeuyejcr6tl2gin65dy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIKHA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

