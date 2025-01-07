module 0xf9ef3e3c29840fbf16b5573a1791c10cd907f1dbd0f8b6395274d9f2059629ea::mamba {
    struct MAMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMBA>(arg0, 6, b"MAMBA", b"MAMBA", b"Mamba pair launch on Sui Network | Buy Mamba with : dex.bluemove.net/swap", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d3iuzwoiyg9qa8.cloudfront.net/webadmin/storage/public/coin-image/mamba.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAMBA>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMBA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAMBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

