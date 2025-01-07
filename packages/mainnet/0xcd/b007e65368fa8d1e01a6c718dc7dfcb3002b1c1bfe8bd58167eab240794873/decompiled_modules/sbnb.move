module 0xcdb007e65368fa8d1e01a6c718dc7dfcb3002b1c1bfe8bd58167eab240794873::sbnb {
    struct SBNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBNB>(arg0, 9, b"SBNB", b"SuiBinance", b"collaboration Sui And Binance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-giant-muskox-172.mypinata.cloud/ipfs/QmNoRQfuoZTBrQ3sVspnZNo8WGwPE8gEcTxMGZpNwDTA69")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SBNB>(&mut v2, 4400000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBNB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBNB>>(v1);
    }

    // decompiled from Move bytecode v6
}

