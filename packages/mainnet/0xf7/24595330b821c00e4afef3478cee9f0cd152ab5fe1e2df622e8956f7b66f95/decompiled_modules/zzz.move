module 0xf724595330b821c00e4afef3478cee9f0cd152ab5fe1e2df622e8956f7b66f95::zzz {
    struct ZZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ZZZ>(arg0, 3, b"ZZZ", b"ZZZ", b"ZZZ, the meme cat coin on the SUI Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://portomasonet.com/favicon.ico")), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZZZ>>(v2);
        0x2::coin::mint_and_transfer<ZZZ>(&mut v3, 900000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZZ>>(v3, v0);
    }

    // decompiled from Move bytecode v6
}

