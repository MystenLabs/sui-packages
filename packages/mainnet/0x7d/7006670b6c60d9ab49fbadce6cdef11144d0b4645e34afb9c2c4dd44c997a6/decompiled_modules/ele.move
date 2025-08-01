module 0x7d7006670b6c60d9ab49fbadce6cdef11144d0b4645e34afb9c2c4dd44c997a6::ele {
    struct ELE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELE>(arg0, 6, b"ELE", b"Ele The Snake", b"$ELE is the new meme-driven utility token built on the Sui blockchain. Olo's cousin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibnenwxxzhfxoapavcfb4d6msaoixy4ifpopfpedmcj347zijhi4a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ELE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

