module 0xc631fcce4d7b2fb95a34981c70d5c293d31e97dd7bbb0126f3a70ed1f96e84eb::rohi {
    struct ROHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROHI>(arg0, 9, b"ROHI", b"Rohit", b"My self ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/84db738a-2e58-4d15-8ba7-b92a525ee955.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

