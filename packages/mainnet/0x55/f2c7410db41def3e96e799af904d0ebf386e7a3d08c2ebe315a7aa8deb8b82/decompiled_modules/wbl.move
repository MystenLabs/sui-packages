module 0x55f2c7410db41def3e96e799af904d0ebf386e7a3d08c2ebe315a7aa8deb8b82::wbl {
    struct WBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WBL>(arg0, 9, b"WBL", b"WBull", b"Wavebull moon bull meme bull", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/878f0daf-1600-4f96-b1fc-f2b587d497e9-IMG_5845.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

