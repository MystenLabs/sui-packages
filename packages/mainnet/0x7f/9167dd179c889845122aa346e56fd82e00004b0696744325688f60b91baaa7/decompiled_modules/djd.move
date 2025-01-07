module 0x7f9167dd179c889845122aa346e56fd82e00004b0696744325688f60b91baaa7::djd {
    struct DJD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJD>(arg0, 9, b"DJD", b"Coddling ", b"Djdk I love this so much I ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/47e1bc3f-2e1f-4e90-8282-bcc36ae44bc2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DJD>>(v1);
    }

    // decompiled from Move bytecode v6
}

