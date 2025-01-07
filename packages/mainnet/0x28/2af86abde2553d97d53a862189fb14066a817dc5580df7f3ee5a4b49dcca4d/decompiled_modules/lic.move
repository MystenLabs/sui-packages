module 0x282af86abde2553d97d53a862189fb14066a817dc5580df7f3ee5a4b49dcca4d::lic {
    struct LIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIC>(arg0, 9, b"LIC", b"Noc", b"Bobe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b0ee6447-7a03-4517-8488-1448b38eefba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

