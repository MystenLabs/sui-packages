module 0x4a52a27f46356a459e53223bc7436a7cdc2bdc33f2a4e24e7462ee4a2610fc39::xpd {
    struct XPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: XPD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XPD>(arg0, 9, b"XPD", b"Expander", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a8b16a64-f7a6-4279-9de1-ee649408a332.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XPD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XPD>>(v1);
    }

    // decompiled from Move bytecode v6
}

