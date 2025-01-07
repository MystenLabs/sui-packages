module 0xc5bf566de0f9ea7ec4dbaf4d5b06bc96b340d9df31a4c1aeebbc56fa66122154::drb {
    struct DRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRB>(arg0, 9, b"DRB", b"Doctor Bak", b"To the Moon and the back ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/360b39f5-d571-4013-a4cb-b13a24c3b88b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

