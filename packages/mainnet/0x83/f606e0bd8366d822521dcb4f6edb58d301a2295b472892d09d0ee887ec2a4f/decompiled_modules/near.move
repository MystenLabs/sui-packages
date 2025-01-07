module 0x83f606e0bd8366d822521dcb4f6edb58d301a2295b472892d09d0ee887ec2a4f::near {
    struct NEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEAR>(arg0, 9, b"NEAR", b"Near", b"Near not far", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/207ac368-1bf0-4a60-9cf6-848556dd4888.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

