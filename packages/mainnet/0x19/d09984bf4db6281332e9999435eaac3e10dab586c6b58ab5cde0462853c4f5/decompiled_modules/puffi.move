module 0x19d09984bf4db6281332e9999435eaac3e10dab586c6b58ab5cde0462853c4f5::puffi {
    struct PUFFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFI>(arg0, 6, b"Puffi", b"Sui Puffi", b"Meet Puffi, The Puffi story written by the Community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihd5ygl4xtagus7uie6fhsdn3orpb5kobqf5r6obxo55m4gohzxeu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUFFI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

