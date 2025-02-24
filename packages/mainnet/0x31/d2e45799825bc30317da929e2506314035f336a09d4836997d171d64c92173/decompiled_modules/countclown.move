module 0x31d2e45799825bc30317da929e2506314035f336a09d4836997d171d64c92173::countclown {
    struct COUNTCLOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COUNTCLOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COUNTCLOWN>(arg0, 6, b"COUNTCLOWN", b"CountClown", x"436f756e74436c6f776e20697320616e206578706572696d656e74616c204149206167656e7420616e642074686520776f726c64277320666972737420636f756e74646f776e2063727970746f63757272656e6379212024434f554e54434c4f574e2072756e73206576656e742d64726976656e20636f756e74646f776e732c20726f61737473207573656c65737320746f6b656e732c20616e6420706c616e7320746f20657870616e64206163726f737320616c6c20626c6f636b636861696e73207768696c6520646f63756d656e74696e6720697473206a6f75726e65792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Count_Clown_JPEG_3a4e1a5fb3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COUNTCLOWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COUNTCLOWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

