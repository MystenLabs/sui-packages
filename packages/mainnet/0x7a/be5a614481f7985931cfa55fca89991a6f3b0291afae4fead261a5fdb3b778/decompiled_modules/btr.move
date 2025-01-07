module 0x7abe5a614481f7985931cfa55fca89991a6f3b0291afae4fead261a5fdb3b778::btr {
    struct BTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTR>(arg0, 9, b"BTR", b"BornToRich", x"4a757374206d656d6520666f7220676f6f64206c69766520f09f9881", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ed2b0bc-0763-403b-bde7-6b7337d3a7da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

