module 0xc0311ac3a021e51ddcd288ef6b59391faca3dfa1201b84a4a9fbf65da54e9ddb::rtn {
    struct RTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTN>(arg0, 9, b"RTN", b"Ritanics ", b"Ritanics is a community-driven meme coin celebrating the excitement and energy of cryptocurrency wave sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc0ef1a2-46d1-437b-8a15-df937ef58b60.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RTN>>(v1);
    }

    // decompiled from Move bytecode v6
}

