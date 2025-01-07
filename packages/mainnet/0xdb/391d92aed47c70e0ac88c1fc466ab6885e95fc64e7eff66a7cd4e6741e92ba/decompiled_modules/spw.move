module 0xdb391d92aed47c70e0ac88c1fc466ab6885e95fc64e7eff66a7cd4e6741e92ba::spw {
    struct SPW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPW>(arg0, 9, b"SPW", b"SPELL WALL", b"Not just an ordinary meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f13c6d42-722e-4cc7-b452-6ca0e40acba2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPW>>(v1);
    }

    // decompiled from Move bytecode v6
}

