module 0x25b8185d249856e878bc85923bb38ac51ac38a2ba0a068a18c43b7372e39c01b::pg {
    struct PG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PG>(arg0, 9, b"PG", b"Pudgy Girls", b"Pudgy Girls is a collection NFTs, waddling through Web3 and a beacon of positivity in the NFT Space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTRwDUPSFGU6E59Hn9wM9G8mNZmXDkttBCgLDGWXR2tsW")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

