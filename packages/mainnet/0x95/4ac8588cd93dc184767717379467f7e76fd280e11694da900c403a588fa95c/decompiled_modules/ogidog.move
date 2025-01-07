module 0x954ac8588cd93dc184767717379467f7e76fd280e11694da900c403a588fa95c::ogidog {
    struct OGIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGIDOG>(arg0, 9, b"OGIDOG", b"Ogi", b"An authentic meme coin derived from the animation Ogi With a reliable and strong community, the possibility of it multiplying, buy it at a low price, don't stay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2b0874df-ea1c-4f2d-b973-ab1263c93f9a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OGIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

