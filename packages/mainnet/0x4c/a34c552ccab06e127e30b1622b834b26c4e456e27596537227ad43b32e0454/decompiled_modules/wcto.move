module 0x4ca34c552ccab06e127e30b1622b834b26c4e456e27596537227ad43b32e0454::wcto {
    struct WCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCTO>(arg0, 9, b"WCTO", b"WeweCTO", b"Meme Wewe CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/939462c0-77b0-477a-ad2e-a88ee00943a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

