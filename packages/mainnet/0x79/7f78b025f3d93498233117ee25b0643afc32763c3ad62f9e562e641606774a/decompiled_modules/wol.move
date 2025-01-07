module 0x797f78b025f3d93498233117ee25b0643afc32763c3ad62f9e562e641606774a::wol {
    struct WOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOL>(arg0, 9, b"WOL", b"WOLF", b"\"Howl at the Moon: Introducing $WOLF, the token that brings crypto investors together, wild and free.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee444b03-09e1-4ea5-a1ed-55a4b05e86ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

