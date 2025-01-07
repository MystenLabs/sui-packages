module 0xe25ca70934fc697ce509e3446d372244e27b5353d4b0a56d6ef9ddddd3341c27::gwnne {
    struct GWNNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GWNNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GWNNE>(arg0, 9, b"GWNNE", b"hswkmw", b"jejen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b7530b55-faa8-4cf8-92b9-beb5a91c35c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GWNNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GWNNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

