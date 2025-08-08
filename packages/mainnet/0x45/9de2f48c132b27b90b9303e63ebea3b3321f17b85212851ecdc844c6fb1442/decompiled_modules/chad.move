module 0x459de2f48c132b27b90b9303e63ebea3b3321f17b85212851ecdc844c6fb1442::chad {
    struct CHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAD>(arg0, 6, b"CHAD", b"CHAD ON SUI", b"The only token made for the Sui chads. High volatility. All to staking, no locks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiflok5heqiesbmr4lamzbn4ochf7kvj3ifi7gzj72kf54wxrqctyi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

