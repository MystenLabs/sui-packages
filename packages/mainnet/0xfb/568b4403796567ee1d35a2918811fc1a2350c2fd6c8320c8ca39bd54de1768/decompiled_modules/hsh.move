module 0xfb568b4403796567ee1d35a2918811fc1a2350c2fd6c8320c8ca39bd54de1768::hsh {
    struct HSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSH>(arg0, 9, b"HSH", b"hash", x"6861736820f09f92b8f09f92b8f09f92b8f09f92b8f09f92b8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/45bc8f97-2f9c-4ac4-ad4e-09434b7eae83.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

