module 0x8246bd20f4efed8a4655088e5cefc5275252661c3f703be3832c324c8f943b5b::cwv {
    struct CWV has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWV>(arg0, 9, b"CWV", b"Cocly Wav", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0c3a8e5f-8d0d-4432-bacc-7982663ce98e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CWV>>(v1);
    }

    // decompiled from Move bytecode v6
}

