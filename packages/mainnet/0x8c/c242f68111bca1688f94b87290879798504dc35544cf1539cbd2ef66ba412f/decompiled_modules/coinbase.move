module 0x8cc242f68111bca1688f94b87290879798504dc35544cf1539cbd2ef66ba412f::coinbase {
    struct COINBASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COINBASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COINBASE>(arg0, 9, b"COINBASE", b"Coinbase", b"Coinbase played us. Time to take the bet and flip their market cap.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYByxpEyf2N34opspiHjJAzoqg38DmdQHFhFWRVt9gkVh")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COINBASE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COINBASE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COINBASE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

