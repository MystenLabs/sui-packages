module 0x63c793f7629fbbced9e5f80c57c88389225e1b3f58433e76de9569743a6adbaa::gzw {
    struct GZW has drop {
        dummy_field: bool,
    }

    fun init(arg0: GZW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GZW>(arg0, 9, b"GZW", b"Gozerow", b"For culture fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/264cff30-32bd-432d-ad17-e45e081f5651.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GZW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GZW>>(v1);
    }

    // decompiled from Move bytecode v6
}

