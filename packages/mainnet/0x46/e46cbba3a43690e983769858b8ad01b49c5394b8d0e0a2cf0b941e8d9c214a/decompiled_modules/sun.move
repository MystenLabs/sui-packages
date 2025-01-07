module 0x46e46cbba3a43690e983769858b8ad01b49c5394b8d0e0a2cf0b941e8d9c214a::sun {
    struct SUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUN>(arg0, 9, b"SUN", b"SUISUN", b"SUISUN is one of the best meme coin built on wave pump which is hilighting the future of SUI project.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5af0e7a8-108f-46c0-b4ca-976e8828a105.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

