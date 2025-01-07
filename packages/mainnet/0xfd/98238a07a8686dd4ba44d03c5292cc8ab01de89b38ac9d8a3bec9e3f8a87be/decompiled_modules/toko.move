module 0xfd98238a07a8686dd4ba44d03c5292cc8ab01de89b38ac9d8a3bec9e3f8a87be::toko {
    struct TOKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKO>(arg0, 9, b"TOKO", b"ToKo ", x"546f6b6f206973207665727920756e686170707920776974682068697320696d707269736f6e6d656e74f09fa4a84275742074686520636f6d6d756e6974792077696c6c20667265652068696df09fa4ab", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d4e37d40-ad7c-4f98-a3e8-5a20f7d0829d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

