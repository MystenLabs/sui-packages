module 0x3137c04676e4b132ddc5e001025d4778d19853c5f6653d6f487dec1d00290f95::vct {
    struct VCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VCT>(arg0, 9, b"VCT", b"VINCENT", b"VINCENT SATORU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0451a488-7b76-46e9-8aa5-6f4872964cb9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

