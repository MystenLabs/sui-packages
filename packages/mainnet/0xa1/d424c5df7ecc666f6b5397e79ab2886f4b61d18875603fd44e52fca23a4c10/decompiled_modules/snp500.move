module 0xa1d424c5df7ecc666f6b5397e79ab2886f4b61d18875603fd44e52fca23a4c10::snp500 {
    struct SNP500 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNP500, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNP500>(arg0, 9, b"SNP500", b"S&P 500", b"$SNP500 is an index compiling the 500 strongest memes on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmV4aiBCekTop5Umd8oxR7xeTieJzfGATXE9roMf3AL7Bx")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNP500>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNP500>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNP500>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

