module 0xa59a1ac111aa831d6306608932af6eddc2f4b3aafec78c193a51de0ad6a92c26::sse {
    struct SSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSE>(arg0, 9, b"SSE", b"seaside", x"52656c617820616e6420756e77696e6420776974682053656173696465436f696e3a2054686520736572656e652063727970746f63757272656e6379207468617427732064656c69766572696e67207761766573206f662070726f6669747320616e642063616c6d696e6720796f757220706f7274666f6c696f2077697468207472616e7175696c206761696e732066726f6d207468652063727970746f2073686f7265732120f09f8f96efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/64224ba4-b288-4797-90c6-d9fac24eb805.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

