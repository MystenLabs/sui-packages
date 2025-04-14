module 0x2f5da3426cad1bcc9fdd14660bf07f784e8651f5bb8b441c5840b74daf1bce42::whale_52hz {
    struct WHALE_52HZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE_52HZ, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 732 || 0x2::tx_context::epoch(arg1) == 733, 1);
        let (v0, v1) = 0x2::coin::create_currency<WHALE_52HZ>(arg0, 8, b"52HZ", b"Whale 52hz", b"52hz so lonely", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/QmRTDzf23zP5Vm8tFLpwg2VzpfRwMyjVSfyfRsvaDMys9p"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WHALE_52HZ>(&mut v2, 5200000000000000000, @0x87982067656c8c3a6e55794eccdc2db681f73262e37a94549f6a42e6843f2599, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE_52HZ>>(v2, @0x87982067656c8c3a6e55794eccdc2db681f73262e37a94549f6a42e6843f2599);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WHALE_52HZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

