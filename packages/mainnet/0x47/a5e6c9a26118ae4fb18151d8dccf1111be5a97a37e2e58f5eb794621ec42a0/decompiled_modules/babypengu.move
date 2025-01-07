module 0x47a5e6c9a26118ae4fb18151d8dccf1111be5a97a37e2e58f5eb794621ec42a0::babypengu {
    struct BABYPENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYPENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPENGU>(arg0, 9, b"BABYPENGU", b"Baby Pengu", b"BabyPengu is here to spread good vibes on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZf7B6QHDu2VjdMZDvD2eH7QzzHjkeWBUmfsr9wDgSs2t")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYPENGU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYPENGU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPENGU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

