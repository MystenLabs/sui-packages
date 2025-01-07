module 0x1aa8684a392c72adf152b093579b0ef63cf287d115d878862e88159c87fd7993::zelya {
    struct ZELYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZELYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZELYA>(arg0, 9, b"ZELYA", b"ZELENSKY", b"Mem-token, launched on popularity of president of Ukraine. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/af984f8b-d7f5-4904-8e77-7e675c217efc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZELYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZELYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

