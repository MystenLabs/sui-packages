module 0x44c32ddb6852b826e02de7c4b2ac1e4beef12d3eb7dc0dc1b4b5bed91602d2a0::sss {
    struct SSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSS>(arg0, 9, b"SSS", b"Siniy", b"Tato", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7219f757-dab2-4b23-b7a5-beb2ea1e2df8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

