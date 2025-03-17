module 0xa0b5cd4281fa1cd8de59de54c1dec19cd0217d4b5f3a9277f29441949c655a46::dothanh {
    struct DOTHANH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOTHANH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOTHANH>(arg0, 9, b"DOTHANH", b"Baki", b"Baki super", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e094dbcf-6c09-4fdb-a246-bfec4061bdb2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOTHANH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOTHANH>>(v1);
    }

    // decompiled from Move bytecode v6
}

