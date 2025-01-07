module 0xbe9c98b8740dc00f8a69cd4bdcc02f161e1b00e9775c93187a44dfc736dbcf6a::ttm {
    struct TTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTM>(arg0, 9, b"TTM", b"ToTheMoon", b"Let rockets only go to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/383ca666-e26a-4d1b-b8cb-dfb309a076c8-IMG_20241004_190522_440.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

