module 0xb645de641f124813dd506ade2b41474d37811c5f0946edd8ee70216ad7c01871::nm {
    struct NM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NM>(arg0, 9, b"NM", b"NOTMEME", b"This is not meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/26685482-0c9d-49b8-9bcb-6cde5276af6b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NM>>(v1);
    }

    // decompiled from Move bytecode v6
}

