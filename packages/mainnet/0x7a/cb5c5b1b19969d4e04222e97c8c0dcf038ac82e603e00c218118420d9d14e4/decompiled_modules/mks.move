module 0x7acb5c5b1b19969d4e04222e97c8c0dcf038ac82e603e00c218118420d9d14e4::mks {
    struct MKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MKS>(arg0, 9, b"MKS", b"MEME KAS", b"Meme Kas is a deflationary token with total supply of 100 million ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4dde11a7-5eb7-46f8-8ebc-54c2ac4bf28d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

