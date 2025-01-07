module 0x70d0cbc43f8e5b00d2f9c0e55cd351eefea95a269f5519d10528e26a24f5d2a9::mue {
    struct MUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUE>(arg0, 9, b"MUE", b"Manzunem", b"Token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e995514d-a7d1-4c93-8abb-0f81b2cc5c7e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

