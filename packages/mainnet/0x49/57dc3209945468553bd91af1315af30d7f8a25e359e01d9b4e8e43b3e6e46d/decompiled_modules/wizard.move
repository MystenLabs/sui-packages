module 0x4957dc3209945468553bd91af1315af30d7f8a25e359e01d9b4e8e43b3e6e46d::wizard {
    struct WIZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIZARD>(arg0, 6, b"Wizard", b"Magic Wizard", b"Magical World", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiau23yzrf6jgamliiatipl2q6ggmbriy5hkxgdxwpx66i3k5pihjy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WIZARD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

