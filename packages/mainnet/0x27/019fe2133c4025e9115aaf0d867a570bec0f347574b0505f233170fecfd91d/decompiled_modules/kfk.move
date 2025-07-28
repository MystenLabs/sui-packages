module 0x27019fe2133c4025e9115aaf0d867a570bec0f347574b0505f233170fecfd91d::kfk {
    struct KFK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KFK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KFK>(arg0, 6, b"KFK", b"Kung Fu Kangaroo", b"Kung Fu Kangaroo is the high-energy memecoin on Sui, bringing kung fu action and kangaroo vibes to the crypto world. With its playful spirit and unstoppable bounce, its all about fun and community. Join the dojo and leap into the excitement!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic6eqdsphsnb4bdse3qwi4m7ffy7anohlygt5na3jfd5jrxdrm2ee")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KFK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KFK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

