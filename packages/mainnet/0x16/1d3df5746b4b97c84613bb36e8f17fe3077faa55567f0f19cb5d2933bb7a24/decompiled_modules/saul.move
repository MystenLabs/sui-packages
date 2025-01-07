module 0x161d3df5746b4b97c84613bb36e8f17fe3077faa55567f0f19cb5d2933bb7a24::saul {
    struct SAUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAUL>(arg0, 9, b"SAUL", b"Saul", b"Better Call Saul", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/78126b5e-9e43-4f09-86cd-b44dcff5ccb1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

