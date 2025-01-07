module 0xad8f4b769e59c60a93ddd1d503b51336ef9072cc823748e2b5dd51b7f1f501b4::primeape {
    struct PRIMEAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRIMEAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIMEAPE>(arg0, 6, b"PRIMEAPE", b"Primeape", b"It becomes wildly furious if it even senses someone looking at it. It chases anyone that meets its glare.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeib64bcgrtyzbpqjvcd2lgbchhljmshs2qrljfe3qf4g4u6cbdbap4.ipfs.dweb.link/Primeape.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PRIMEAPE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIMEAPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRIMEAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

