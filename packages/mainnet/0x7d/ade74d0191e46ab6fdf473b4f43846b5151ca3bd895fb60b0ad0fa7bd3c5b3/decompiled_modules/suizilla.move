module 0x7dade74d0191e46ab6fdf473b4f43846b5151ca3bd895fb60b0ad0fa7bd3c5b3::suizilla {
    struct SUIZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZILLA>(arg0, 9, b"SUIZILLA", b"SuiZilla", b"SUIZILLA IS MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-giant-muskox-172.mypinata.cloud/ipfs/QmTDEv3694WF9eVqyyeQrTs37yHNjzBTUgcku7B3uhApWS")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIZILLA>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZILLA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

