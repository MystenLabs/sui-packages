module 0x261d5870bc4ef64fa4f0e6980783342d7757d34412099e8e25e7e47bd3e233dd::l {
    struct L has drop {
        dummy_field: bool,
    }

    fun init(arg0: L, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<L>(arg0, 9, b"L", b"Lynx", b"Lynx Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/34c627a4-1d61-4b6c-bece-f72f7ecf2959-images (5).jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<L>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<L>>(v1);
    }

    // decompiled from Move bytecode v6
}

