module 0x6a08a2445dff2a72ee68ddd9323acecbae4e50369c4fb6f9112360088d0449dd::bad {
    struct BAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAD>(arg0, 9, b"BAD", b"Badbeast", b"Beast is back", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/57f0e755-655b-4ab2-bd41-273f0846bf00.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

