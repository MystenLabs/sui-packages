module 0x7f788051969b046e318e49ecaee2d284c7cc8f2d2955e146d559ecd471378565::memefi {
    struct MEMEFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEFI>(arg0, 9, b"MEMEFI", b"Meme ", x"4272696c6c69616e742070726f6a65637420f09f918d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/51555431-79c1-484e-8e7a-19ff602245f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

