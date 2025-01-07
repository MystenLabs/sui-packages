module 0xf078d1f1cadb1a5c644c9844ef8252987833814136bda525e8058c2b9de91c26::tbs {
    struct TBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBS>(arg0, 9, b"TBS", b"Kabosu", b"Kabosu will be pump 100,000X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/82a26670-3e47-484f-ac3f-2e6880d4c7b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

