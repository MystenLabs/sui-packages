module 0x4f8649aae782de59b469b7a8e46e49fd14afb994d779fd13298a740f2f1adec1::sossa {
    struct SOSSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOSSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOSSA>(arg0, 9, b"sossa", b"Sossa", b"creator of bitcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmdCPJoxgCrMErsCSXWzVfDNjGMwFEPTdiwu83jkuLxutC?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOSSA>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOSSA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOSSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

