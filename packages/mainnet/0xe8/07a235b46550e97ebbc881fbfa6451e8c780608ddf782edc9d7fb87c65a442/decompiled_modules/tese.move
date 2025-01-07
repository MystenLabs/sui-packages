module 0xe807a235b46550e97ebbc881fbfa6451e8c780608ddf782edc9d7fb87c65a442::tese {
    struct TESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESE>(arg0, 9, b"TESE", b"Omontese", b"Sui meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f4d87da2-d459-45fb-bf78-e6a2497007a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESE>>(v1);
    }

    // decompiled from Move bytecode v6
}

