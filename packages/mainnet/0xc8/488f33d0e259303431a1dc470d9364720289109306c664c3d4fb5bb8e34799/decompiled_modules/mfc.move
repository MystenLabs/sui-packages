module 0xc8488f33d0e259303431a1dc470d9364720289109306c664c3d4fb5bb8e34799::mfc {
    struct MFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<MFC>(arg0, 6, b"MFC", b"Modman Foundation Coin", b"Modman Foundation Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1722038581038-66f7f9813c33032b86bfc7f1904c22b2.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MFC>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<MFC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

