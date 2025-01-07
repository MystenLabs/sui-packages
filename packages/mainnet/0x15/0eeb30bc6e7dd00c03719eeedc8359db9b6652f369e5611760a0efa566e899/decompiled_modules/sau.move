module 0x150eeb30bc6e7dd00c03719eeedc8359db9b6652f369e5611760a0efa566e899::sau {
    struct SAU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAU>(arg0, 9, b"SAU", b"Tokensau", b"Sautokensauhaibon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6d991bd6-d654-411b-8406-a1e8660fd062.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAU>>(v1);
    }

    // decompiled from Move bytecode v6
}

