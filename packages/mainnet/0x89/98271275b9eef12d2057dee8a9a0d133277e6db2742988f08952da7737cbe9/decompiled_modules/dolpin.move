module 0x8998271275b9eef12d2057dee8a9a0d133277e6db2742988f08952da7737cbe9::dolpin {
    struct DOLPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPIN>(arg0, 6, b"DOLPIN", b"DOLPIN SUI", x"24446f6c70696e2077696c6c206275696c6420405375694e6574776f726b20616e6420416c6f6e67207769746820636f6d6d756e697479200a0a4d616b6520746865204265737420746865204d656d65436f696e20200a0a4974206973207265616c2024444f4c50494e2074696d6520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_1_49154f0081.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLPIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

