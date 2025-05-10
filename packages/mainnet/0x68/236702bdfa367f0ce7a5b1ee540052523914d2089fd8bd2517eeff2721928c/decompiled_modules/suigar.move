module 0x68236702bdfa367f0ce7a5b1ee540052523914d2089fd8bd2517eeff2721928c::suigar {
    struct SUIGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGAR>(arg0, 6, b"SUIGAR", b"Suigar Pokemon", b"Building the first pokemon TCG game on the Sui network . $SUIGAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifozgtv3vbr3fmfqsrliwve4pqs4vdxfch3iqftouy2vfoitvw5oa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIGAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

