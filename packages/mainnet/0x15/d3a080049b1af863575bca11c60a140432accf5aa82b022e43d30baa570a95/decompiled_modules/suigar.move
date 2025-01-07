module 0x15d3a080049b1af863575bca11c60a140432accf5aa82b022e43d30baa570a95::suigar {
    struct SUIGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGAR>(arg0, 9, b"SUIGAR", b"Suigar", x"24535549474152202d2074686520737765657465737420746f6b656e206f6e2053554920f09f8dac20526561647920746f20737072696e6b6c6520796f757220706f7274666f6c696f207769746820737567617279206761696e7320f09f92b8e28189efb88f2047657420796f757220736c696365206f662074686520616374696f6e20616e64207361746973667920796f75722063727970746f2063726176696e677320f09f9a80202353776565744761696e73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/7jnwdB3sMejZq97V7mwpwUajhxbhxJFaaM7Tyn6M9sSH.png?size=lg&key=8d0bbb")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIGAR>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGAR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

