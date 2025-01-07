module 0x4048beba5e451c2414029f4e4cc9826dbbb89b34055548ee362b8ab2e885c9ab::king {
    struct KING has drop {
        dummy_field: bool,
    }

    fun init(arg0: KING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KING>(arg0, 9, b"KING", b"King Paw", b"The cute cat king who can bring good luck to those who own it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e1d301dc-8057-464a-9564-6c8d5a1e4ea8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KING>>(v1);
    }

    // decompiled from Move bytecode v6
}

