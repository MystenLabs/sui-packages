module 0x5da5024bd76f6cf1fd5e1cb6927d0a603402a1da35db64cff360b414c77fa899::kem {
    struct KEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEM>(arg0, 9, b"KEM", b"Poodle Dog", b"This is my poodle dog. His name is Kem. He is so cute and active. I live him so much !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c6e8262-5b8c-4fbf-94ef-81e9d70882f0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

