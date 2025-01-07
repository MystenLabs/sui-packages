module 0x872aba12cc9e74cf9fd79650e9d95ec77449a91bb11e1996a5d074ac734e8484::suigirl {
    struct SUIGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGIRL>(arg0, 9, b"SUIGIRL", b"Sui Girl", b"Girl Water Join Meme Season", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-giant-muskox-172.mypinata.cloud/ipfs/QmXU1vQ1TzuMoXT7adNigQ4Een1v6NBmBTf1ipMMqKvi2y")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIGIRL>(&mut v2, 45555000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGIRL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

