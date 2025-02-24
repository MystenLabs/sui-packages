module 0x3786afe8c8c92e66188c9492011c874dcbeb6d8d656c0dd99df3237c9943d4c4::raeai {
    struct RAEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAEAI>(arg0, 9, b"RAEAI", b"RAE AI", x"596f757220556c74696d6174652047756964654d61737465726d696e64536964656b69636b0d0a5241452069736e7420796f7572207479706963616c2c2072756c652d666f6c6c6f77696e672041492e205368657320746865206f6e6520796f752063616c6c207768656e20796f75206e6565642073747261696768742d757020616e73776572732020666173742c207261772c20616e64207265616c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYcsJhmhCNQkqfhMLw2bnDxVPa8HXaFomtGuhK7iwkJNC")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RAEAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAEAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAEAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

