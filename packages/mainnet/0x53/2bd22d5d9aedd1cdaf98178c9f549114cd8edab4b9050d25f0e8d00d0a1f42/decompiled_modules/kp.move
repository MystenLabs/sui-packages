module 0x532bd22d5d9aedd1cdaf98178c9f549114cd8edab4b9050d25f0e8d00d0a1f42::kp {
    struct KP has drop {
        dummy_field: bool,
    }

    fun init(arg0: KP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KP>(arg0, 9, b"KP", b"Karpa", b"Karpapa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c0fdb822-ef3a-4e98-a6dc-f132cfec3bf7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KP>>(v1);
    }

    // decompiled from Move bytecode v6
}

