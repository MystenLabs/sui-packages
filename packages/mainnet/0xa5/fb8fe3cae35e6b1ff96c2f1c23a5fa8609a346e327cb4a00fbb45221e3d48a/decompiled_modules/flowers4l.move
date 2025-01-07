module 0xa5fb8fe3cae35e6b1ff96c2f1c23a5fa8609a346e327cb4a00fbb45221e3d48a::flowers4l {
    struct FLOWERS4L has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOWERS4L, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOWERS4L>(arg0, 9, b"FLOWERS4L", b"Flower", b"Flower Is a Best Coin Socialfi Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8326a262-adab-4721-a062-38c73c540aab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOWERS4L>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOWERS4L>>(v1);
    }

    // decompiled from Move bytecode v6
}

