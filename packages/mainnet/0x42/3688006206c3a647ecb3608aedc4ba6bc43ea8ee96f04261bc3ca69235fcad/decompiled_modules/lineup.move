module 0x423688006206c3a647ecb3608aedc4ba6bc43ea8ee96f04261bc3ca69235fcad::lineup {
    struct LINEUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LINEUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LINEUP>(arg0, 9, b"LINEUP", b"LINEUP", b"LINEUP is the premium, cross-game loyalty and progression layer of the Lineup Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lineupgames.myfilebase.com/ipfs/QmPyhaPAozTZzQdNygCPUx6jMRe3yS5Z29ttHhDPB7dcCb")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<LINEUP>>(0x2::coin::from_balance<LINEUP>(0x2::coin::mint_balance<LINEUP>(&mut v2, 1000000000000000000), arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LINEUP>>(v1);
        0x423688006206c3a647ecb3608aedc4ba6bc43ea8ee96f04261bc3ca69235fcad::treasury::share<LINEUP>(0x423688006206c3a647ecb3608aedc4ba6bc43ea8ee96f04261bc3ca69235fcad::treasury::wrap<LINEUP>(v2, arg1));
    }

    // decompiled from Move bytecode v6
}

