module 0x208250035e8288141700bd820da5b08d2efbd1e74c9f15bf9ff9987d6e5305a7::suidog {
    struct SUIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOG>(arg0, 9, b"SUIDOG", b"Sui Dog", b"SUI DOG : https://t.me/suidogtoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-giant-muskox-172.mypinata.cloud/ipfs/QmWXsFg9brFaNjQPvVrUF9VrmeDzuGASCWYusa1QhuMM4K")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIDOG>(&mut v2, 666666666000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

