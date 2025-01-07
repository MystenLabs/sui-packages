module 0x86d9221550cf4ed5aa8dfea415cf7e7b41f7b9799427f61f00c09fae4b750fa5::tix {
    struct TIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIX>(arg0, 9, b"TIX", b"tipoX", b"TipoX is a cutting-edge cryptocurrency designed to revolutionize the way we handle digital transactions. Built on a secure and scalable blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5fd0d9af-d2e5-4c87-916d-0cd5e41ebd49.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

