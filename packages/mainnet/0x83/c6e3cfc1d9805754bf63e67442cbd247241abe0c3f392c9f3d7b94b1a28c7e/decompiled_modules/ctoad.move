module 0x83c6e3cfc1d9805754bf63e67442cbd247241abe0c3f392c9f3d7b94b1a28c7e::ctoad {
    struct CTOAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTOAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTOAD>(arg0, 9, b"CTOAD", b"Chilling Toad", b"$CTOAD - The most chilling toad. Didn't care plus not selling.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreighvpczunc62zxhg5357lofdrmllq3p3yw5ejzxg6bjtbltupzdwy.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CTOAD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTOAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTOAD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

