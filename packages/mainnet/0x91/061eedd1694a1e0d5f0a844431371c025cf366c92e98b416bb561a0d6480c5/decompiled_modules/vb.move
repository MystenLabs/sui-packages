module 0x91061eedd1694a1e0d5f0a844431371c025cf366c92e98b416bb561a0d6480c5::vb {
    struct VB has drop {
        dummy_field: bool,
    }

    fun init(arg0: VB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VB>(arg0, 9, b"VB", b"FGN", b"FHD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/22f1c9e2-3d78-4098-9796-873dd1879e6b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VB>>(v1);
    }

    // decompiled from Move bytecode v6
}

