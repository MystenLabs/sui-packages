module 0xe9b28ebf02ee8c9c45ed9ebede0f6726a56f0c603fdb4f1709b11d8cadcd85a3::neged {
    struct NEGED has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEGED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEGED>(arg0, 9, b"NEGED", b"DEGEN", b"Let's have it on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/49b64f33-6b8f-4e58-9b47-2bab3dabab5d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEGED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEGED>>(v1);
    }

    // decompiled from Move bytecode v6
}

