module 0xbfc7b53265e852d72cfdee4c336779179863e713fd0a322788d01e3be4f2cd04::donald {
    struct DONALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONALD>(arg0, 9, b"DONALD", b"UNOFFICIAL DONALD TRUMP", b"UNOFFICIAL DONALD TRUMP ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSkwApkwf4wPveMx8oNMDzJndL3J6ctTa6JY1PBtgY7JU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DONALD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONALD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONALD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

