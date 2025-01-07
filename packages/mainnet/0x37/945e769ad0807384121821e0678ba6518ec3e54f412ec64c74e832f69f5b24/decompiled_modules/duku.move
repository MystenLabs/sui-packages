module 0x37945e769ad0807384121821e0678ba6518ec3e54f412ec64c74e832f69f5b24::duku {
    struct DUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUKU>(arg0, 9, b"DUKU", b"Duku kong", b"Dukukong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ebee5800-56df-465d-b727-1c7a36bcff0a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

