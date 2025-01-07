module 0x50daa31a0b0bcbfd3c8145f349cfce5329b6f5af1dcfbc16718e2f4c94f656be::pia {
    struct PIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIA>(arg0, 9, b"PIA", b"Pika Pika", b"Pika Pika Pi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c7152f0d-1e9f-4d08-b15a-94afef463f9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

