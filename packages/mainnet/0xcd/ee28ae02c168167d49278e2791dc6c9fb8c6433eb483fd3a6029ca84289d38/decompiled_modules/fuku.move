module 0xcdee28ae02c168167d49278e2791dc6c9fb8c6433eb483fd3a6029ca84289d38::fuku {
    struct FUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUKU>(arg0, 9, b"FUKU", b"Fuk", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/183c747b-c396-4ba4-8f73-4092603ff1c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

