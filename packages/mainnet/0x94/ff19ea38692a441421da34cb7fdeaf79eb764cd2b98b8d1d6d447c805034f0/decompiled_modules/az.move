module 0x94ff19ea38692a441421da34cb7fdeaf79eb764cd2b98b8d1d6d447c805034f0::az {
    struct AZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZ>(arg0, 9, b"AZ", b"Azuki sui", x"313030252052657761726420666f7220436f6d6d756e697479202c205765627369746520736f6f6e20f09f948d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/41a3003c-8ad2-4454-adef-df06b1aad984.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

