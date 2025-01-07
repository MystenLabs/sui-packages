module 0xdae88b79f22eb1128958f0ad940861da797467c311f53010220cc9fb0eee5ac7::fggggggggg {
    struct FGGGGGGGGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGGGGGGGGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGGGGGGGGG>(arg0, 9, b"FGGGGGGGGG", b"hhhhhhhhhh", b"gggggggggggggggggg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/44ed1921-0b39-441e-809e-231e48fb0329.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGGGGGGGGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FGGGGGGGGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

