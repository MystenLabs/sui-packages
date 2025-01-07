module 0x2522a88a294380711ab70ed99bb5412a42e207449e75cd92c46cee200d566bf0::rohi {
    struct ROHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROHI>(arg0, 9, b"ROHI", b"Rohit", b"My self ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f4e3c46d-3aef-4d2c-8fee-0a0f360c9002.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

