module 0xb4e31943c24f03e63a747cb24ce7be0dbdf737d29b8f26f7f598174f9a7fc99f::hc {
    struct HC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HC>(arg0, 9, b"HC", b"Hot Chi", b"Hot as you arr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/48766850-20ac-421a-89bf-fadb85be6e3e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HC>>(v1);
    }

    // decompiled from Move bytecode v6
}

