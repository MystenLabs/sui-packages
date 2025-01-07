module 0x963f18a9a26d83df4e4e73c157049227ae10efd8ce26a4dff8e57ebd2dee2cfa::tgm {
    struct TGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGM>(arg0, 9, b"TGM", b"THANGAM", b"THANGAM is a heartfelt initiative dedicated to promoting global healing through love, compassion, and community engagement. Our mission is to inspire individuals and communities to come together, fostering a culture of k", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/35dc019d-f068-4abd-b275-34e3fb8540cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TGM>>(v1);
    }

    // decompiled from Move bytecode v6
}

