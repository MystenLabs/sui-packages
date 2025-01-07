module 0xc1fd7891a0b6425f19af67f12c415cede639a9ddd8b8edc46e60b69c4570ad9c::ded {
    struct DED has drop {
        dummy_field: bool,
    }

    fun init(arg0: DED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DED>(arg0, 9, b"DED", b"Deadpool", b"Pamp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/239ad48a-2b4a-4c5f-9fa1-1bc995f4d85e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DED>>(v1);
    }

    // decompiled from Move bytecode v6
}

