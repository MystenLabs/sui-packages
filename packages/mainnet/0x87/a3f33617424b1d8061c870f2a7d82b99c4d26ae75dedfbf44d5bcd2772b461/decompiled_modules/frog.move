module 0x87a3f33617424b1d8061c870f2a7d82b99c4d26ae75dedfbf44d5bcd2772b461::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROG>(arg0, 9, b"FROG", b"Frogs", b"A meme in sui and wave ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f1687d9-1044-4cd3-be55-d40056f1aea1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

