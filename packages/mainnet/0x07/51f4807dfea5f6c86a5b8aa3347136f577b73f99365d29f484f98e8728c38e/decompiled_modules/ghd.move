module 0x751f4807dfea5f6c86a5b8aa3347136f577b73f99365d29f484f98e8728c38e::ghd {
    struct GHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHD>(arg0, 9, b"GHD", b"Gemhold", b"It is an undervalued gem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1a163296-9546-4c3b-bd26-be6a7b65b79a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHD>>(v1);
    }

    // decompiled from Move bytecode v6
}

