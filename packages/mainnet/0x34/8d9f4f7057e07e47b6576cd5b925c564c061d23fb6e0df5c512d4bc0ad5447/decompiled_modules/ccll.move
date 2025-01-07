module 0x348d9f4f7057e07e47b6576cd5b925c564c061d23fb6e0df5c512d4bc0ad5447::ccll {
    struct CCLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCLL>(arg0, 9, b"CCLL", b"CClare", b"We are need friends like this.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb9e1207-35f7-4884-a01b-274ccd5dfae7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

