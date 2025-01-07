module 0x665cb8308baa37f4fccd3eb64b100117d481006db4c59f4b8957704541144d9a::husl {
    struct HUSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUSL>(arg0, 9, b"HUSL", b"Husl", b"The Land", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1601d807-a666-4343-b67e-abf449920b0e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUSL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUSL>>(v1);
    }

    // decompiled from Move bytecode v6
}

