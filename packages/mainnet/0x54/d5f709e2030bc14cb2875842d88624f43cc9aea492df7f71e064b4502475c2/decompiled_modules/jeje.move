module 0x54d5f709e2030bc14cb2875842d88624f43cc9aea492df7f71e064b4502475c2::jeje {
    struct JEJE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEJE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEJE>(arg0, 9, b"JEJE", b"Jeje on Sui", b"Say hello to jeje most famous emoji on discord", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmf8crikVzZnXGgr2MCEg3ryDaV69UbXgcwdzJxQ2ivpBK")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JEJE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JEJE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEJE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

