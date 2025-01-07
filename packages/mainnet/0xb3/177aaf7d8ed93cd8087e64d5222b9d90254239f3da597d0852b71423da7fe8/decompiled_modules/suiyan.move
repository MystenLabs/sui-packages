module 0xb3177aaf7d8ed93cd8087e64d5222b9d90254239f3da597d0852b71423da7fe8::suiyan {
    struct SUIYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIYAN>(arg0, 6, b"SUIYAN", b"Suiyan Cat", x"5468652069636f6e6963206e79616e2063617420697320706f756e63696e672069747320776179206f6e205355492c2061206c6567656e64617279206d656d6520776974682061206c6567656e64617279206272616e64696e67210a0a687474703a2f2f73756979616e6361742e636f6d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_N_D_D_D_D_D_D_2024_10_14_202150189_87977a5771.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIYAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIYAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

