module 0xb2183a942e5b53d590cad6d48d0aec514f067c1a553694b63f25cbb5bc7e03dc::gt {
    struct GT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GT>(arg0, 9, b"GT", b"GANGSTER", b"MEME GANGSTER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0c3e0899-bff8-44c9-be87-e955e892be1d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GT>>(v1);
    }

    // decompiled from Move bytecode v6
}

