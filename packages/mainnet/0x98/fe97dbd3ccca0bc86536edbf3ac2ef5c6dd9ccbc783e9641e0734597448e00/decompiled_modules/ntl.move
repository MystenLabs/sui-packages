module 0x98fe97dbd3ccca0bc86536edbf3ac2ef5c6dd9ccbc783e9641e0734597448e00::ntl {
    struct NTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTL>(arg0, 9, b"NTL", b"Dragon8368", b"I like this project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/11d7340d-1f8c-4bb1-b34d-bf44f8e46049.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

