module 0xe7b76360e05ac6d3444213539cb20b8f253cbdd073c7a8683aac98f4f8ad6345::sji {
    struct SJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJI>(arg0, 9, b"SJI", b"Saiji", b"Purely meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f11a0436-28c3-4f2d-91f2-70cb40c6fbc3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

