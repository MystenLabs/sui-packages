module 0x298fdd46e7192c474d962de6291e10bee583961ebd9199239838719ceba2561e::bgrl {
    struct BGRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGRL>(arg0, 9, b"BGRL", b"THE GIRL", b"A stylish and sophisticated digital currency inspired by the beauty and elegance of black hair", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2fa14e26-6792-4889-b6fd-5bb57374a342.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BGRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

