module 0xe18d67c89d89222550f403445a313c9cda82a7f5df048c1f4893d6a563158510::cats6868 {
    struct CATS6868 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATS6868, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATS6868>(arg0, 9, b"CATS6868", b"Cats", b"Cats on Wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1dcbd358-63e4-4c3e-b78d-2a6270e72027.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATS6868>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATS6868>>(v1);
    }

    // decompiled from Move bytecode v6
}

