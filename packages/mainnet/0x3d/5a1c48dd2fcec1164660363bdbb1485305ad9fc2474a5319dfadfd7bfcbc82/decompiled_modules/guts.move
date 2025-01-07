module 0x3d5a1c48dd2fcec1164660363bdbb1485305ad9fc2474a5319dfadfd7bfcbc82::guts {
    struct GUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUTS>(arg0, 9, b"GUTS", b"Guts Dogs ", x"2447555453206d656d65636f696e7320696e66726173747275637475726520636f6d6d756e697479206275696c6420616e64206b65657020636f6f6b20f09f94a5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9d9f999a-2cbc-4443-84db-c66f3d27f69a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

