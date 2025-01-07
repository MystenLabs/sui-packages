module 0xd7f6c67f66ea3532c0ce06d61322e3a890507776881b06800f7f68f624977381::cty {
    struct CTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTY>(arg0, 9, b"CTY", b"city", x"496c6c756d696e61746520796f757220706f7274666f6c696f20776974682043697479436f696e3a2054686520757262616e2063727970746f63757272656e637920746861742773206c69676874696e67207570207468652066696e616e6369616c206469737472696374207769746820736b797363726170696e672070726f6669747320616e6420627573746c696e67206f70706f7274756e697469657320696e207468652063697479736361706520f09f8c8620f09f8c8620f09f8c8620f09f8c8620f09f8c8620f09f8c86", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c8480255-67cc-40d1-8c44-d9eaac33db32.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

