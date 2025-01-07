module 0x869c83de0c9dc07fb8c16b8efe53018da016173c6b9847efa2168b27b1d32318::cleo {
    struct CLEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLEO>(arg0, 9, b"CLEO", b"Binance old fur-nancial advisor", b"https://x.com/binance/status/1248973179965468677", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPSVB9ig1LoHTQZFitYYjTvvK5T5oQydjWrX6RvJwyXzE")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLEO>>(v1);
        0x2::coin::mint_and_transfer<CLEO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLEO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

