module 0x261bb7f05bcec509e2e737d3c12bf08fb9a5bba8566c2f43092375dd9eb0b465::major {
    struct MAJOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAJOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAJOR>(arg0, 9, b"MAJOR", b"Major coin", b"Major is a meme toke", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/89a25f23-77fc-48d8-9a48-708ee17ebcfe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAJOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAJOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

