module 0xa2c9d54030082fb6b411fecfa590633847ff78e8177ac088dec18397e3a0cc93::opts {
    struct OPTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPTS>(arg0, 9, b"OPTS", b"Optimusui ", b"Optimusui is meme bot on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/78f164d0-53e1-4902-b7c6-40292cf6bdd3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

