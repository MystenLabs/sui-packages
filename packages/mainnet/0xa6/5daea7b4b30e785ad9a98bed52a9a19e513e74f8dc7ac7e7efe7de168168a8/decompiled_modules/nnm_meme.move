module 0xa65daea7b4b30e785ad9a98bed52a9a19e513e74f8dc7ac7e7efe7de168168a8::nnm_meme {
    struct NNM_MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNM_MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NNM_MEME>(arg0, 9, b"NNM_MEME", b"Nakl155", b"Meme nmnme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0ef22719-1f7f-4293-a1e0-3e0f6f6e87a1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNM_MEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NNM_MEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

