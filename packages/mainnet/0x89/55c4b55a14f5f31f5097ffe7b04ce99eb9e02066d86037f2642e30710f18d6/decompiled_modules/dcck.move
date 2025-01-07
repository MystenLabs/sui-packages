module 0x8955c4b55a14f5f31f5097ffe7b04ce99eb9e02066d86037f2642e30710f18d6::dcck {
    struct DCCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCCK>(arg0, 9, b"DCCK", b"DCCK Air", b"DCCK Aidrop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0d675adf-9704-426e-9a76-b999916fc79a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DCCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

