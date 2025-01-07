module 0x41bb5fb33d36928f2a24fb45915539bb3ab11b44ef555d47805c6da6a165e8b7::fx {
    struct FX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FX>(arg0, 9, b"FX", b"Fixee coin", b"Beautiful meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30521576-2508-45aa-ae9a-636ee23c25aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FX>>(v1);
    }

    // decompiled from Move bytecode v6
}

