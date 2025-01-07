module 0xa25b66694da10760944fa773b674321c3ba3059c5446095e50da1434052b7d0f::lala {
    struct LALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LALA>(arg0, 9, b"LALA", b"Lam", x"54686520636f696ee280997320706c617966756c206964656e746974792069732073796d626f6c697a65642062792069747320636174636879207469636b65722c20244c414c412c20616e64206974732076696272616e7420737469636b65722064657369676e2c206d616b696e6720697420696e7374616e746c79207265636f676e697a61626c6520696e20746865206d656d6520636f696e2073706163652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/297f507b-fb10-430c-8080-e031c71e9479.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

