module 0xaecd9ba1d1c996bc375522832304cb18d5dbce7976718a7e1edcb15b5e446b27::gny {
    struct GNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GNY>(arg0, 9, b"GNY", b"greeny", b"Zoom into the future with greenycoin: The lightning-fast crypto that's all about speed, fun, and meme magic at warp speed!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/395813ae-47e1-45a0-94b7-c0e214b678d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

