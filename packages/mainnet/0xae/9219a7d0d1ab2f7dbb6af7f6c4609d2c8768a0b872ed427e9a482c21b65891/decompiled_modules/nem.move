module 0xae9219a7d0d1ab2f7dbb6af7f6c4609d2c8768a0b872ed427e9a482c21b65891::nem {
    struct NEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEM>(arg0, 9, b"NEM", b"Nemo", b"meme representing the famous fish Nemo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/20cf00cb-6729-4f38-b7ea-bcba82078429.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

