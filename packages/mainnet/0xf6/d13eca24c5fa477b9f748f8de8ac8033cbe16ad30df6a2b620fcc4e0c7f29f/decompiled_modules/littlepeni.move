module 0xf6d13eca24c5fa477b9f748f8de8ac8033cbe16ad30df6a2b620fcc4e0c7f29f::littlepeni {
    struct LITTLEPENI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LITTLEPENI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LITTLEPENI>(arg0, 9, b"LITTLEPENI", b"Penguin", b"It's meme token for trading looking forward for bright future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e4088148-75cb-4a45-aae5-04c8023d44ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LITTLEPENI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LITTLEPENI>>(v1);
    }

    // decompiled from Move bytecode v6
}

