module 0x950ebc347d8059fefb02797a3e936a5edde05a8e4edc62a2cd2a99f9837079c5::doges {
    struct DOGES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGES>(arg0, 9, b"DOGES", b"DOGE state", x"546865206f6666696369616c20444f47452073746174650d0a0d0a436f6e747261637420616464726573733a20424658686277347350546b335276544450615a6b6e315774327932764c55796357414a4d6e59624d70756d70", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTqUacroHK1uwicUzo1hRxCLaQmjvc2py1AeT2MA9UFue")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGES>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGES>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

