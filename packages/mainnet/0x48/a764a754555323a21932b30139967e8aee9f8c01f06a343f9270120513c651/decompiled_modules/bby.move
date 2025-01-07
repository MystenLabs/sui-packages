module 0x48a764a754555323a21932b30139967e8aee9f8c01f06a343f9270120513c651::bby {
    struct BBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBY>(arg0, 9, b"BBY", b"Bboy Coin ", b"The Bboys coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c2ea550c-6d22-4d02-9aef-85d56f7d577e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

