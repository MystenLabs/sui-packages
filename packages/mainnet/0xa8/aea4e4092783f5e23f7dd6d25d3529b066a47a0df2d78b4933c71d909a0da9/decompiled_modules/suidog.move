module 0xa8aea4e4092783f5e23f7dd6d25d3529b066a47a0df2d78b4933c71d909a0da9::suidog {
    struct SUIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOG>(arg0, 9, b"SUIDOG", b"Sui Dog", b"SUIDOG A.k.a SEADOG : https://t.me/suidogtoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-giant-muskox-172.mypinata.cloud/ipfs/QmR2oYTsGdYTSJEeBDoNJ6mVuTFWz5KnFhQQ93NNC7Qyue")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIDOG>(&mut v2, 144000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

