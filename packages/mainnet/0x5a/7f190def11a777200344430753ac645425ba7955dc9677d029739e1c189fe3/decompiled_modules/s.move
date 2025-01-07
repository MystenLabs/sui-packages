module 0x5a7f190def11a777200344430753ac645425ba7955dc9677d029739e1c189fe3::s {
    struct S has drop {
        dummy_field: bool,
    }

    fun init(arg0: S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S>(arg0, 9, b"S", b"G", b"H", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1e1f1f34-9a53-45ad-92e0-2141827f32cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<S>>(v1);
    }

    // decompiled from Move bytecode v6
}

