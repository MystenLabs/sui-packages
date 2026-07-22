module 0xe73620d5139ef98bdd5cfa9a849bd5e89221403833c3bf21362e3cc4423065a9::mkldof {
    struct MKLDOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MKLDOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MKLDOF>(arg0, 9, b"MKLDOF", b"MKLDOF", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/IUIehIVr8EDH2sDHahlhWwqJnjPdatS1UO8NxsSfOhs")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MKLDOF>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MKLDOF>>(v2, @0x4dc4ae114dcf6fb4e1bc66f492703a740fb8dc0d3186629e38765569dcca4f37);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MKLDOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

