module 0x5605772d62f4f53bc886892009487563fec3f0ca5d366014340df557e06b7af4::snz {
    struct SNZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNZ>(arg0, 6, b"SNZ", b"Senzui", b"Forged in the heart of Sui, SENZUI is a digital asset guided by the discipline of the future a token where precision meets purpose. With the spirit of a cybernetic ronin, SENZUI blends advanced tech with a code of integrity, built for those who see blockchain not just as a system, but as a battleground of innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidbpqxvwlt67aa33y36gucrkmc3jmqax7prvmtuo6qau3q3uc6jca")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

