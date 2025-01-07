module 0x317467138c4e1fee816f8421a4c181aa69119ecc2b62971494660c1ee18df5ac::qris {
    struct QRIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: QRIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QRIS>(arg0, 9, b"QRIS", b"MemeXQris", b"Create by ESSGabut", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5a46d261-f415-49fc-b5be-56cf09a1f22c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QRIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QRIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

