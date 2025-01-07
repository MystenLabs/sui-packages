module 0xd48112ee1ffb42dc67816dfe16fbd5db5ec0f056bf6a99ce699c6c71411dc115::khung {
    struct KHUNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHUNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHUNG>(arg0, 9, b"KHUNG", b"Kyo khung", b"Kyo khung dien", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7719adf2-e6ec-426d-8a47-b3333add9dbd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHUNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KHUNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

