module 0x9b8a45bcc5c606e059f1d544e52f0a8edc0c9c012444d1ad9ed5a300b6440b37::vb {
    struct VB has drop {
        dummy_field: bool,
    }

    fun init(arg0: VB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VB>(arg0, 9, b"VB", b"AF", b"B XC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c63e3d5a-1fc8-4187-be48-bd9b5d02f99d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VB>>(v1);
    }

    // decompiled from Move bytecode v6
}

