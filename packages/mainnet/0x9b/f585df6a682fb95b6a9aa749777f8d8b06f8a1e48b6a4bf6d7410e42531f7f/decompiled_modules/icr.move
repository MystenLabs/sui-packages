module 0x9bf585df6a682fb95b6a9aa749777f8d8b06f8a1e48b6a4bf6d7410e42531f7f::icr {
    struct ICR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICR>(arg0, 9, b"ICR", b"ICARUS", b"ICARUS is an innovative crypto token designed to empower creators and support artistic projects. Through a decentralized platform, ICARUS connects artists and supporters, ensuring fair compensation and fostering creativity in the digital age.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9f9a24cb-166b-4752-83c3-1f982dc5418b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ICR>>(v1);
    }

    // decompiled from Move bytecode v6
}

