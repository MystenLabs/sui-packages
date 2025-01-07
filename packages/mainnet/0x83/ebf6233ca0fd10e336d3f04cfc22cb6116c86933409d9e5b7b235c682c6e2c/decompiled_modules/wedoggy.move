module 0x83ebf6233ca0fd10e336d3f04cfc22cb6116c86933409d9e5b7b235c682c6e2c::wedoggy {
    struct WEDOGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEDOGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEDOGGY>(arg0, 9, b"WEDOGGY", b"WAVE", b"is a token that represents the growth of dog memes, the entire meme market in general, and wave in particular.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7fb29100-696d-4839-8e1a-4327c949207e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEDOGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEDOGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

