module 0x378a11b92925fa89b8f12c00f53daddee4ab5e2ef06b72d781ab9e25ebfda0ef::wgt {
    struct WGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WGT>(arg0, 9, b"WGT", b"Weight", b"Weighing the intensity of the crypto bullrun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c265aad-4b3f-4909-9fc0-0a25448c8333.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

