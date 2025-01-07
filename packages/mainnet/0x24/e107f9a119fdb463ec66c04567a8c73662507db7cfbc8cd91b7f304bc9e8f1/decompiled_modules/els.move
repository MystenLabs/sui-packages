module 0x24e107f9a119fdb463ec66c04567a8c73662507db7cfbc8cd91b7f304bc9e8f1::els {
    struct ELS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELS>(arg0, 9, b"ELS", b"Elon sui", b"Elon on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b18e2cf0-52a8-47c2-b2dd-0ce61ddc1c24.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELS>>(v1);
    }

    // decompiled from Move bytecode v6
}

