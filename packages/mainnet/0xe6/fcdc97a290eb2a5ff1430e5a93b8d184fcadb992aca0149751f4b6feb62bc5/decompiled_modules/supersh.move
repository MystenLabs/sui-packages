module 0xe6fcdc97a290eb2a5ff1430e5a93b8d184fcadb992aca0149751f4b6feb62bc5::supersh {
    struct SUPERSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERSH>(arg0, 9, b"SUPERSH", b"Spasibo", x"d0b1d0bbd0b0d0b3d0bed0b4d0b0d180d18e20d0a1d0bfd0b0d181d0b8d0b1d0be", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6a90957-3041-402b-878e-d9a4422de9e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPERSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

