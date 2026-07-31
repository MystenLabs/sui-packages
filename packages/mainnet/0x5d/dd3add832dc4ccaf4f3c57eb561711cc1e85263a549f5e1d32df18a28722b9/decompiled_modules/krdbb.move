module 0x5ddd3add832dc4ccaf4f3c57eb561711cc1e85263a549f5e1d32df18a28722b9::krdbb {
    struct KRDBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRDBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRDBB>(arg0, 10, b"KRDBB", b"KRDBB", b"KRDBB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeicvoounsnezrbuivnebsrndwslhnmrsehosovntt2wslsvynzpny4")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<KRDBB>>(0x2::coin::mint<KRDBB>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRDBB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRDBB>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

