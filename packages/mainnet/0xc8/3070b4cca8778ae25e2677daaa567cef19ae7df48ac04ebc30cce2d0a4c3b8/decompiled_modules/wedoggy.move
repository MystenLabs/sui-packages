module 0xc83070b4cca8778ae25e2677daaa567cef19ae7df48ac04ebc30cce2d0a4c3b8::wedoggy {
    struct WEDOGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEDOGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEDOGGY>(arg0, 9, b"WEDOGGY", b"WAVE", b"is a token that represents the growth of dog memes, the entire meme market in general, and wave in particular.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dabc2719-f3de-479b-806f-46b2f9c1253a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEDOGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEDOGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

