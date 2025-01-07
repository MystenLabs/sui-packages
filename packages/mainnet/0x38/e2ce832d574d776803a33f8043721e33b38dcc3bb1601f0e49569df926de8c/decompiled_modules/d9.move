module 0x38e2ce832d574d776803a33f8043721e33b38dcc3bb1601f0e49569df926de8c::d9 {
    struct D9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: D9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D9>(arg0, 9, b"D9", b"Dn99", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/abe3de44-a5ef-4ef3-a052-d868b3e7b8e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D9>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<D9>>(v1);
    }

    // decompiled from Move bytecode v6
}

