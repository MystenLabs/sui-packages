module 0xbab699cff31868a62777404f5edc49dd48e6907d165a1f2084de4c86d936e2b8::hao4 {
    struct HAO4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAO4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAO4>(arg0, 6, b"HAO4", b"HAO004", b"004", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://lh4.googleusercontent.com/proxy/CK0npX1aNSQYDuMkNfA3L-xGCNb8YsV6_hASTcBwwRfuOSzrTRKhowo9okDdSFefKB1-tS1ivATi0J3leIv-QjZiIwn0sAou6Vzv6DJHngE23g2q"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HAO4>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAO4>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HAO4>>(v2);
    }

    // decompiled from Move bytecode v6
}

