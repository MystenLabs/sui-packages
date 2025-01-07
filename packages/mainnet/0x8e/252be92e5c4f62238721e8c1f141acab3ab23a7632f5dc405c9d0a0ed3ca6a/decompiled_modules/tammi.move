module 0x8e252be92e5c4f62238721e8c1f141acab3ab23a7632f5dc405c9d0a0ed3ca6a::tammi {
    struct TAMMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAMMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAMMI>(arg0, 9, b"TAMMI", b"Tammicon", x"54616d6d6927732066616d696c792073796d626f6c20696e2046696e6c616e642068747470733a2f2f742e6d652f626c756d2f6170703f73746172746170703d6d656d657061646a6574746f6e5f54414d4d495f46754433312d7265665f6b7773347968676849670a4c657427732073656e642054414d4d4920746f20746865206d6f6f6e20746f676574686572212041726520796f7520776974682075733f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/46bbf626-91f0-4aaa-9c0c-94f8374dc918.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAMMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAMMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

