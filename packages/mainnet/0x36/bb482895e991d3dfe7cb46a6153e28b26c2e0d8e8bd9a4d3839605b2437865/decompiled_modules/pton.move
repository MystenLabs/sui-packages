module 0x36bb482895e991d3dfe7cb46a6153e28b26c2e0d8e8bd9a4d3839605b2437865::pton {
    struct PTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTON>(arg0, 9, b"PTON", b"Plankton", b"Just Plankton = P L A N K T O N", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/67387aa9-c892-4bdb-9707-3bf23bd1c000-1000000050.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTON>>(v1);
    }

    // decompiled from Move bytecode v6
}

