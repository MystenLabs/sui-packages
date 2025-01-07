module 0x41d309dc6e4ac350f3cd729dda4f50c56406f9311cb4f8ffe31d49447ffb33e9::tgm {
    struct TGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGM>(arg0, 9, b"TGM", b"THANGAM", b"THANGAM is a heartfelt initiative dedicated to promoting global healing through love, compassion, and community engagement. Our mission is to inspire individuals and communities to come together, fostering a culture of k", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b3e0783b-2c31-41cd-aa81-4c9cce5b4428.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TGM>>(v1);
    }

    // decompiled from Move bytecode v6
}

