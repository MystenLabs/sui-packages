module 0x519b5ce6dfe98adef341390775b4c2b6fa9d476a40924e721ba1cf39e18cc28e::auc {
    struct AUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUC>(arg0, 9, b"AUC", b"AUconn.", b"AUconn. is a meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0359c232-21da-4fac-bda3-2df541950411.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AUC>>(v1);
    }

    // decompiled from Move bytecode v6
}

