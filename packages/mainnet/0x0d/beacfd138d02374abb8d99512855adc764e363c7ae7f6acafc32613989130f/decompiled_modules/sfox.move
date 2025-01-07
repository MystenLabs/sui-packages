module 0xdbeacfd138d02374abb8d99512855adc764e363c7ae7f6acafc32613989130f::sfox {
    struct SFOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFOX>(arg0, 9, b"SFOX", b"FOXONSUI", x"53464f583a20416e206578636974696e67206a6f75726e657920746f206578706c6f726520576562330a53464f58206973206120756e697175652063727970746f63757272656e6379206f6e2074686520537569206e6574776f726b2c2074616b696e6720796f75206f6e206120636f6c6f7266756c20616476656e7475726520696e2074686520776f726c64206f6620576562332e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d7cf587c-b713-4b97-a6a7-33dfcbb1e32a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

