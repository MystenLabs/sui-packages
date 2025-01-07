module 0x1cc38752ef3f0b03e0ca748bbcd71a2878dd188c25d13608be54f582b62e0aea::njw {
    struct NJW has drop {
        dummy_field: bool,
    }

    fun init(arg0: NJW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NJW>(arg0, 9, b"NJW", b"Najwas", b"Family token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f9e3b261-d858-4dd3-a4f3-26f02b11cd78.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NJW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NJW>>(v1);
    }

    // decompiled from Move bytecode v6
}

