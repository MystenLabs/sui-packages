module 0xec0dd4edc6f860d59cbad86a5e262255c4d3c100bb91abb9cb34d13c3cfb140a::honeymoon {
    struct HONEYMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONEYMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONEYMOON>(arg0, 9, b"HONEYMOON", b"Honey ", b"Honey token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/daa4ee69-88fb-4765-a40b-f551a33d6d48.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONEYMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HONEYMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

