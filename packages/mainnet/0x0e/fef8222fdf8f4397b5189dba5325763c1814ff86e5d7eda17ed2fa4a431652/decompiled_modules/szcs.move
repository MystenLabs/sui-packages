module 0xefef8222fdf8f4397b5189dba5325763c1814ff86e5d7eda17ed2fa4a431652::szcs {
    struct SZCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SZCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SZCS>(arg0, 9, b"SZCS", b"Zugacoin", x"5a554741434f494e206973206120756e6971756520627261696e6368696c64206f66204e69676572696127732041726368426973686f702053616d205a7567612e0a0a5a756761636f696e206f6e20546f6e206973206120726562697274682062656e65666974696e6720616c6c2077686f20656e67616765207769746820746865206d6f76656d656e74206173207765207374616e64206173204166726963612773205072696e6365737320746f2072656275696c64204166726963612773206479696e672065636f6e6f6d7920616e6420726573746f72652074686520686f7065206f6620686f70656c657373222e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fadefe1f-684d-4093-8756-de4898c7f5c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SZCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SZCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

