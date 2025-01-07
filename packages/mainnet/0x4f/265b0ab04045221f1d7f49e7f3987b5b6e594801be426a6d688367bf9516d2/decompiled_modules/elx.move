module 0x4f265b0ab04045221f1d7f49e7f3987b5b6e594801be426a6d688367bf9516d2::elx {
    struct ELX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELX>(arg0, 9, b"ELX", b"ElonX", b"Elon Musk SpaceX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/36a66aae-1c88-4815-be15-a3e53fa0766b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELX>>(v1);
    }

    // decompiled from Move bytecode v6
}

