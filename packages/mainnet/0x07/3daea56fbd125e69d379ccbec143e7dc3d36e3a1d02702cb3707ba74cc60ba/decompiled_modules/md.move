module 0x73daea56fbd125e69d379ccbec143e7dc3d36e3a1d02702cb3707ba74cc60ba::md {
    struct MD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MD>(arg0, 9, b"MD", b"Mood", b"A meme project under sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9bb15da0-cb61-4fa4-b71c-6f2a81ec3e0e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MD>>(v1);
    }

    // decompiled from Move bytecode v6
}

