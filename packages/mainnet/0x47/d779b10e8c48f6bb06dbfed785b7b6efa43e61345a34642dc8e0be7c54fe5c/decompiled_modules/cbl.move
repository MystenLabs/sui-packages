module 0x47d779b10e8c48f6bb06dbfed785b7b6efa43e61345a34642dc8e0be7c54fe5c::cbl {
    struct CBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBL>(arg0, 9, b"CBL", b"Coin blee", b"This is a marketing meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6b4e6c74-6afc-45da-bbf9-a02b3a12a191.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

