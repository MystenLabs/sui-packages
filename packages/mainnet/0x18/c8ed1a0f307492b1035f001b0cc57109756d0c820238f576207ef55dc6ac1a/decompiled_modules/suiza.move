module 0x18c8ed1a0f307492b1035f001b0cc57109756d0c820238f576207ef55dc6ac1a::suiza {
    struct SUIZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZA>(arg0, 6, b"SUIZA", b"Suiza", x"5355495a4120697320616e20616476616e636564204149206167656e74206275696c7420746f2070726f76696465207265616c2d74696d65206461746120616e616c79736973206f66207468652024535549206e6574776f726b2e204974207370656369616c697a657320696e20747261636b696e672070726963652c2054564c2c20616e642065636f73797374656d207472656e64732c206f66666572696e67206465657020696e73696768747320696e746f20245355497320446546692070726f746f636f6c732e20466972737420436974697a656e206f66202441544c0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737011314780.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIZA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

