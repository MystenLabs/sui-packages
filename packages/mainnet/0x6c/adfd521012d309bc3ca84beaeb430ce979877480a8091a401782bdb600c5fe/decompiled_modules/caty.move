module 0x6cadfd521012d309bc3ca84beaeb430ce979877480a8091a401782bdb600c5fe::caty {
    struct CATY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATY>(arg0, 9, b"CATY", b"Catsky", b"Catsky is meme cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53e7613d-e313-4738-84a7-10a9a04d8c6e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATY>>(v1);
    }

    // decompiled from Move bytecode v6
}

