module 0x6bd2dbfc6d74af1a722dacd051d01118545e938f8ff210da1e87f8afc527df63::deep {
    struct DEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEP>(arg0, 9, b"DEEP", b"Deep AI", b"Discover a world of creativity anew with hundreds of AI models on one platform.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRZKnX11wmh1nAGegb2uo2UQWrX96KvvFoT8rZGYTdCJY")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEEP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEEP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

