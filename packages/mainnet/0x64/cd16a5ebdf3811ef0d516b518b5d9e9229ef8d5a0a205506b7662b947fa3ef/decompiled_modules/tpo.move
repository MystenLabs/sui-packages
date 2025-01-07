module 0x64cd16a5ebdf3811ef0d516b518b5d9e9229ef8d5a0a205506b7662b947fa3ef::tpo {
    struct TPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPO>(arg0, 9, b"TPO", b"TRUMPO", b"Its", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/acb4bea6-f5f7-4d24-b10c-b95eb601089a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

